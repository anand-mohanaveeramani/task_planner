json.array!(@leaves) do |leave|
  json.extract! leave, :id, :leave_date, :member_id
  json.url leave_url(leave, format: :json)
end
