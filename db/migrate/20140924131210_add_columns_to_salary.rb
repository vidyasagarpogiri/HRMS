class AddColumnsToSalary < ActiveRecord::Migration
  def change
    add_column :salaries, :gross_salary, :float
    add_column :salaries, :gratuity, :float
    add_column :salaries, :bonus, :float
    add_column :salaries, :medical_insurance, :float
    add_column :salaries, :pf, :float
    add_column :salaries, :esic, :float
    add_column :salaries, :special_allowance, :float
    add_column :salaries, :pf_apply, :string
    add_column :salaries, :esic_apply, :string
    add_column :salaries, :pf_contribution, :float
    add_column :salaries, :esic_contribution, :float
  end
end
