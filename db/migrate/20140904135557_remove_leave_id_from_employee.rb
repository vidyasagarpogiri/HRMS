class RemoveLeaveIdFromEmployee < ActiveRecord::Migration
  def change
  
   remove_column :employees, :leave_id
  end
end
