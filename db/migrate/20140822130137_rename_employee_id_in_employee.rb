class RenameEmployeeIdInEmployee < ActiveRecord::Migration
  def change
    rename_column :employees, :employee_is, :employee_id
  end
end
