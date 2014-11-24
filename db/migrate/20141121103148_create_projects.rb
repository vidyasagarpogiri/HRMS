class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :roles
      t.text :tasks_performed
      t.text :skills

      t.timestamps
    end
  end
end
