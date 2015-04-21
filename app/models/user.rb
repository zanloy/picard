require 'bcrypt'

class User < ActiveRecord::Base

  before_create :build_profile, :build_notification

  # Associations
  has_one :profile, autosave: true, dependent: :destroy
  has_one :notification, autosave: true, dependent: :destroy
  has_many :engineering_changes, foreign_key: :poc_id
  has_many :subscriptions, dependent: :destroy
  has_many :comments

  # Validation
  validates_presence_of :email

  # Scopes
  scope :sorted, -> { order(:name) }
  scope :enabled, -> { where(enabled: true) }

  # Virtual attributes for password
  attr_accessor :new_password, :new_password_confirmation
  # Validate the password only if the password is changed
  validates_confirmation_of :new_password, if: :password_changed?

  before_save :hash_new_password, if: :password_changed?

  def password_changed?
    !@new_password.blank?
  end

  def name_or_email
    if self.name.nil? || self.name.empty?
      return self.email
    else
      return self.name
    end
  end

  def self.authenticate(email, password)
    if user = find_by_email(email)
      if BCrypt::Password.new(user.hashed_password).is_password? password
        return user
      end
    end
    return nil
  end

  def self.from_omniauth(auth)
    # Validate the only omniauth logins are allowed from sparcedge.com
    if auth.info.email.split('@')[1] != 'sparcedge.com'
      redirect_to signin_path, notice: 'You must use an @sparcedge.com for Google Auth login.'
    end
    #where(email: auth.info.email, provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  private

  def hash_new_password
    self.hashed_password = BCrypt::Password.create(@new_password)
  end

end
