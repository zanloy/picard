class List < ActiveRecord::Base

  belongs_to :last_added_by, class_name: User
  has_many :list_items, dependent: :destroy

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
