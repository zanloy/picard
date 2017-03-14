# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Notification, type: :model do
  it 'created notifications automatically' do
    expect { create(:user) } .to change { Notification.count } .by(1)
  end
end
