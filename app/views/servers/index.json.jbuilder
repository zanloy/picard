json.array!(@servers) do |server|
  json.extract! server, :id, :name, :environment_id, :ip_address, :ports
  json.url server_url(server, format: :json)
end
