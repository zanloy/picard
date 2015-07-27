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

  #def self.respond_to?(method_sym, include_private = false)
  #  if fields.includes? method_sym.to_s
  #    true
  #  else
  #    super
  #  end
  #end

  #def self.method_missing(method_sym, *arguments, &block)
  #  puts "Method missing called. #{method_sym}"
  #  if fields.includes? method_sym.to_s
  #    get_field(method_sym)
  #  else
  #    super
  #  end
  #end

end
