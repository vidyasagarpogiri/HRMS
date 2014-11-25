class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.string :description
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
