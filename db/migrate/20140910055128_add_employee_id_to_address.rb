class AddEmployeeIdToAddress < ActiveRecord::Migration
  def change
			add_column :addresses, :employee_id, :integer
			add_column :addresses, :type, :boolean, :default => 0
			remove_column :employees, :present_address_id, :integer
			remove_column :employees, :permanent_address_id, :integer
  end
end
