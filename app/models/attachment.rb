# frozen_string_literal: true
class Attachment < ActiveRecord::Base

  before_create :assign_reference

  has_attached_file :file, styles: { thumb: '100x100>' }

  # Associations
  belongs_to :engineering_change

  # Validations
  validates :engineering_change, presence: true
  validates_attachment :file, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png', 'application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']}

  private
    def assign_reference
      max = engineering_change.attachments.order('reference DESC').first
      begin
        self.reference = max.reference + 1
      rescue
        self.reference = 1
      end
    end

end
