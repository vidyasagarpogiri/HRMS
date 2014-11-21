class AddGroupToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :group_id, :integer
  end
end
