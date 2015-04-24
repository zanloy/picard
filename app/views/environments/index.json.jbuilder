json.array!(@environments) do |environment|
  json.extract! environment, :id, :name, :domain
  json.url server_url(environment, format: :json)
end
