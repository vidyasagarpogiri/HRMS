class AddColumnToAllowance < ActiveRecord::Migration
  def change
      add_column :allowances, :salary_id, :integer
  end
end
