json.array!(@members) do |member|
  json.extract! member, :id, :name, :deliver_rate
  json.url member_url(member, format: :json)
end
