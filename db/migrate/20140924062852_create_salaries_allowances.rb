class CreateSalariesAllowances < ActiveRecord::Migration
  def change
    create_table :salaries_allowances do |t|
      t.integer :salary_id
      t.integer :allowance_id
      t.string :apply_date
      t.timestamps
    end
  end
end
