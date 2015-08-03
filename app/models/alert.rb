class Alert < ActiveRecord::Base

  # Class Variables
  OPERATORS = %w[== != > < >= <=]

  # Associations
  belongs_to :list

  # Validations
  validates_presence_of :list, :field, :operator, :value
  validates_inclusion_of :operator, in: OPERATORS

  # Instance Methods
  def to_s
    "#{field} #{operator} #{value}"
  end

end
