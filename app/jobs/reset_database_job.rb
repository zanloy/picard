# frozen_string_literal: true

# ActiveJob to reset database
class ResetDatabaseJob < ActiveJob::Base
  Picard::Application.load_tasks

  queue_as :default

  def perform(*)
    Rake::Task['db:reset'].invoke if Rails.env.demo?
  end
end
