json.array!(@projects) do |project|
  json.extract! project, :id, :name, :details, :quarter_id, :points, :priority, :completion
  json.url project_url(project, format: :json)
end
