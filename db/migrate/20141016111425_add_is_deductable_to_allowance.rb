class AddIsDeductableToAllowance < ActiveRecord::Migration
  def change
    add_column :allowances, :is_deductable, :boolean, :default => false
  end
end
