class ChangeRoleIdEmployee < ActiveRecord::Migration
  def change
    rename_column :employees, :Role_id, :role_id
  end
end
