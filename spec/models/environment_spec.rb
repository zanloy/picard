# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Environment, type: :model do
  context 'validations' do
    subject { build(:environment) }

    it { should validate_presence_of :name }
  end
end
