class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :previous_company
      t.string :last_designation
      t.date :from_date
      t.date :to_date
      t.references :employee
      t.timestamps
    end
  end
end
