class AddColumnLeaveIdtoEmployee < ActiveRecord::Migration
  def change
     add_column :employees, :leave_id, :integer
  end
end
