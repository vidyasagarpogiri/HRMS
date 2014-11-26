class AddColumnsToPayRollMaster < ActiveRecord::Migration
  def change
    add_column :pay_roll_masters, :status, :string
  end
end
