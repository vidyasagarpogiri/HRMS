class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :specilization
      t.string :institute
      t.date :year_of_admission
      t.date :year_of_pass
      t.float :cgpa_percentage

      t.timestamps
    end
  end
end
