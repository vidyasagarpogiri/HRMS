class AddRoleRefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :role, index: true
  end
end
