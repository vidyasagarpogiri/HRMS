class AddIsDeductableToStaticAllowance < ActiveRecord::Migration
  def change
    add_column :static_allowances, :is_deductable, :boolean
  end
end
