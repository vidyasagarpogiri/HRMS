class AddColumnToAllowances < ActiveRecord::Migration
  def change
    add_column :allowances, :allowance_value, :float
  end
end
