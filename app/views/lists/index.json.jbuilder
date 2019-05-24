# frozen_string_literal: true

json.array!(@lists) do |list|
  json.extract! list, :id
  json.url list_url(list, format: :json)
end
