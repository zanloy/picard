class ResetDatabaseJob < ActiveJob::Base

  Picard::Application.load_tasks

  queue_as :default

  def perform(*args)
    if Rails.env.demo?
      Rake::Task['db:reset'].invoke
    end
  end

end
