class AddRoleRefToRolePrevilige < ActiveRecord::Migration
  def change
    add_reference :role_previliges, :role, index: true
  end
end
