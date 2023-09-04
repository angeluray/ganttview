class CreateDiagrams < ActiveRecord::Migration[7.0]
  def change
    create_table :diagrams do |t|
      t.string :task_name
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :progress
      t.string :duration
      t.string :priority
      t.string :parent

      t.timestamps
    end
  end
end
