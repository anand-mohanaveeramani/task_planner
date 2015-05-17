json.array!(@leaves) do |leafe|
  json.extract! leafe, :id, :leave_date, :member_id
  json.url leafe_url(leafe, format: :json)
end
