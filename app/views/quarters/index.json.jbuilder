json.array!(@quarters) do |quarter|
  json.extract! quarter, :id, :year, :index
  json.url quarter_url(quarter, format: :json)
end
