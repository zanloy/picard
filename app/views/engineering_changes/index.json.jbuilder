# frozen_string_literal: true

json.array!(@changes) do |change|
  json.extract! change, :id, :title, :entered_by_id, :poc_id, :environment_id, :all_tags
  json.url engineering_change_url(change, format: :json)
end
