class CreateEmployeeSkills < ActiveRecord::Migration
  def change
    create_table :employee_skills do |t|
      t.integer :skill_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
