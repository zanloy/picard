class List < ActiveRecord::Base

  # Associations
  belongs_to :last_added_by, class_name: User
  has_many :list_items, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :schema, presence: true, json: true

  def parsed
    return JSON.parse(schema)
  end

  def fields
    begin
      parsed.keys
    rescue
      []
    end
  end

end
