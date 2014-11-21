class AddEmployeeToProject < ActiveRecord::Migration
  def change
     add_column :projects, :employee_id, :integer
  end
end
