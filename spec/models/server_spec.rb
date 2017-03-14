# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Server, type: :model do
  context 'validations' do
    subject { build(:server) }

    it { should validate_presence_of :name }
  end

  it 'generates an api key' do
    expect(create(:server).api_key).not_to be_nil
  end
end
