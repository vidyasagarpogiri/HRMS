class ChangeRoleIdEmployee < ActiveRecord::Migration
  
  def up
    rename_column :employees, :Role_id, :role_id
  end
  

end
