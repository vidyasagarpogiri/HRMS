class AddColumnGroupIdtoEmployee < ActiveRecord::Migration
  def up
   add_column :employees, :group_id, :integer
  end
  def down
   remove_column :employees, :group_id
  end

end
