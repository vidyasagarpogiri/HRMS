class AddShiftIdToEmployees < ActiveRecord::Migration
 def change
     add_column :employees, :shift_id, :integer 
  end
end
