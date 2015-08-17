class Server < ActiveRecord::Base

  # Associations
  belongs_to :environment

  # Validations
  validates_presence_of :name

  # Actions
  before_save :generate_apikey

  def generate_apikey
    loop do
      key = SecureRandom.hex(32)
      if Server.find_by(api_key: key) == nil
        self.api_key ||= key
        break
      end
    end
  end

end
