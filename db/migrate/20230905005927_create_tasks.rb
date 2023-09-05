class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :task_description
      t.datetime :start_date
      t.datetime :end_date
      t.string :duration
      t.integer :parent_unique_id
      t.integer :unique_task_id
      t.references :project, null: false, foreign_key: true
      t.references :task_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
