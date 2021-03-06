# frozen_string_literal: true
require 'bcrypt'

class User < ActiveRecord::Base

  before_create :build_profile, if: :missing_profile?
  before_create :build_notification
  after_create :send_notifications
  before_save :downcase_email
  before_save(:enable_user) if Rails.env.demo?

  # Associations
  has_attached_file :avatar, styles: { icon: '50x50>', thumb: '100x100>' }, default_url: 'missing/avatar-:style.jpg'
  has_one :profile, autosave: true, dependent: :destroy
  has_one :notification, autosave: true, dependent: :destroy
  has_many :engineering_changes, foreign_key: :poc_id, dependent: :nullify
  has_many :subscriptions, dependent: :destroy
  has_many :comments, dependent: :nullify

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :notification

  # Validation
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false, message: 'Email is already associated with another user'
  validates_presence_of :name
  validates_attachment_content_type :avatar, content_type: /\Aimage/

  # Scopes
  scope :sorted,   -> { order(:name) }
  scope :emails,   -> { enabled.pluck(:email) }
  scope :enabled,  -> { where(enabled: true, banned: false) }
  scope :banned,   -> { where(banned: true) }
  scope :disabled, -> { where(enabled: false, banned: false) }

  # Virtual attributes for password
  attr_accessor :new_password, :new_password_confirmation
  # Validate the password only if the password is changed
  validates_confirmation_of :new_password, if: :password_changed?
  validates :new_password, password_strength: true, if: :password_changed?

  before_save :hash_new_password, if: :password_changed?

  def password_changed?
    !@new_password.blank?
  end

  def admin?
    admin
  end

  def name_or_email
    if self.name.nil? || self.name.empty?
      return self.email
    else
      return self.name
    end
  end

  def self.authenticate(email, password)
    email.downcase!
    if user = find_by_email(email)
      if BCrypt::Password.new(user.hashed_password).is_password? password
        return user
      end
    end
    return nil
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.avatar = URI.parse(auth.info.image) if auth.info.image?
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at) if user.oauth_expires_at
      user.save!
    end
  end

  def enabled?
    return false if banned
    return false unless enabled
    return true
  end

  private

  def hash_new_password
    self.hashed_password = BCrypt::Password.create(@new_password)
  end

  def enable_user
    self.enabled = true
  end

  def send_notifications
    Notification.where(on_new_user: true).each do |notification|
      unless notification.user.enabled? == false
        Emailer.delay.new_user(notification.user, self)
      end
    end
  end

  def missing_profile?
    return self.profile.nil?
  end

  def downcase_email
    self.email.downcase!
  end

end
