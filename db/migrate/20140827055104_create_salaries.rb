class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.float :ctc_fixed
      t.float :basic_salary

      t.timestamps
    end
  end
end
