class AddEmployeeIdToLeave < ActiveRecord::Migration
  def change
    add_column :leaves, :employee_id, :integer
  end
end
