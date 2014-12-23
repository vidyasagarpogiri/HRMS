class AddColumnsToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :available_leaves, :float
  end
end
