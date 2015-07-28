class ListItem < ActiveRecord::Base

  # Associations
  belongs_to :list, counter_cache: true
  belongs_to :updated_by, class: User

  # Validations
  validates :payload, presence: true, json: true

  # Callbacks
  after_find :create_methods

  # We override super.initialize because we need to create the methods for
  # our meta fields before initialization
  def initialize(attributes = nil, options = {})
    if attributes
      if attributes.has_key? :list
        raise 'list is not type List' unless attributes[:list].is_a? List
        list = attributes[:list]
      else
        raise 'list_id is required' unless attributes.has_key? 'list_id'
        raise 'list not found' unless list = List.find(list_id)
      end
      create_methods(list.fields)
    end
    super
  end

  def payload=(arg)
    super
    create_methods
  end

  def parsed
    begin
      return JSON.parse(payload)
    rescue
      return {}
    end
  end

  def fields
    begin
      return parsed.keys
    rescue
      return nil
    end
  end

  def get_field(field)
    parsed[field.to_s] || ''
  end

  def set_field(field, value)
    buffer = parsed
    buffer[field.to_s] = value
    self.payload = JSON.generate(buffer)
  end

  def get_field_type(field)
    list.get_field(field)
  end

  def create_methods(fields = nil)
    if fields == nil
      fields ||= self.fields
      fields += list.fields if list
    end
    fields.each do |field|
      self.class.send(:define_method, field) { get_field(field) }
      self.class.send(:define_method, "#{field}=") { |arg| set_field(field, arg) }
    end
  end

  def to_s
    parsed.map { |k,v| "#{k}: #{v}" }.join(', ')
  end

end
