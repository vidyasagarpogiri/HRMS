class AddColumnsToSalary < ActiveRecord::Migration
  def change
		add_column :salaries, :gross_salary, :float
		add_column :salaries, :gratuity, :float
		add_column :salaries, :bonus, :float
		add_column :salaries, :medical_insurance, :float
		add_column :allowances, :applicable, :boolean
  end
end
