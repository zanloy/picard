require 'rails_helper'

RSpec.describe Alert, type: :model do
  it 'creates a valid object'
  it 'is invalid without a :list'
  it 'is invalid if :list is not a List'
  describe 'operator' do
    it 'is valid with a valid operator'
    it 'is invalid with a bad operator'
  end
end
