class Alert < ActiveRecord::Base

  # Associations
  belongs_to :list

  # Validations
  validates_presence_of :list, :field, :operator, :value
  # TODO: Validate that the operator is in OPERATORS

  # Class Variables
  OPERATORS = %w[== != > < >= <=]

  # Instance Methods
  def to_s
    "#{field} #{operator} #{value}"
  end

end
