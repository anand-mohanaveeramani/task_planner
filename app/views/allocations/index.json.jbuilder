json.array!(@allocations) do |allocation|
  json.extract! allocation, :id, :member_id, :project_id
  json.url allocation_url(allocation, format: :json)
end
