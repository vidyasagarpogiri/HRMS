class CreateSalaryIncrements < ActiveRecord::Migration
  def change
    create_table :salary_increments do |t|
      t.date :increment_date
      t.float :increment_value

      t.timestamps
    end
  end
end
