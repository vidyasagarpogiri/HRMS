class RemoveLeaveIdFromEmployee < ActiveRecord::Migration
  def change
  
   remove_column :employees, :leave_id
   remove_column :employees, :designation_id
   remove_column :employees, :group_id
  end
end
