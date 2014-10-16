class AddIsDeductableToAllowance < ActiveRecord::Migration
  def change
    add_column :allowances, :is_deductable, :boolean
  end
end
