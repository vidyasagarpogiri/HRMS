class RemoveLopAppliedFromLeave < ActiveRecord::Migration
  def change
    remove_column :leaves, :lop_applied
  end
end
