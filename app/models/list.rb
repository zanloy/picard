class List < ActiveRecord::Base

  # Associations
  belongs_to :last_added_by, class_name: User
  has_many :list_items, dependent: :destroy
  has_many :alerts, dependent: :destroy

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

  def date_fields
    dates = []
    parsed.each do |k,v|
      dates << k if v.strip == 'date'
    end
    return dates
  end

  def get_field(field)
    parsed[field.to_s]
  end

  def alerted_items
    alerted = []
    list_items.each do |item|
      alerts.each do |alert|
        # Doing eval is always dangerous with user provided variables so
        # caution should be taken to valid them before using them.

        # Setup variables for the test
        # TODO: change this so it works on non-date fields as well
        diff = Date.today - Date.parse(item.get_field(alert.field))
        oper = alert.operator
        val = alert.value
        # Perform the actual test
        alerted << item if eval("#{diff} #{oper} #{val}")
      end
    end
    return alerted
  end

end
