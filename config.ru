# frozen_string_literal: true
# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

if ENV['SLACK_ENABLED'] == true then
  require ::File.expand_path('../bot/slack', __FILE__)

  Thread.abort_on_exception = true
  Thread.new do
    PicardSlackBot.run
  end
end

run Rails.application
