json.extract! task, :id, :task_name, :task_description, :start_date, :end_date, :duration, :parent_unique_id, :unique_task_id, :project_id, :task_type_id, :created_at, :updated_at
json.url task_url(task, format: :json)
