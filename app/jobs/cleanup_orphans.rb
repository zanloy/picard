# frozen_string_literal: true

# ActiveJob to clean up orphaned changes
class CleanupOrphansJob < ActiveJob::Base
  queue_as :default

  def perform(*)
    orphans = EngineeringChange.where(poc: nil)
    orphans.each do |orphan|
      orphan.update(poc: User.first)
    end
  end
end
