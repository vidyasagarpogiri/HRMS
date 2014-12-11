class AddColumnsToRole < ActiveRecord::Migration
  def change
    add_column :roles, :department_id, :integer
    add_column :roles, :designation_id, :integer
  end
end
