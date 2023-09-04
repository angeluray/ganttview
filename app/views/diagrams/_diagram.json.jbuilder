json.extract! diagram, :id, :task_name, :description, :start_date, :end_date, :progress, :duration, :priority, :parent, :created_at, :updated_at
json.url diagram_url(diagram, format: :json)
