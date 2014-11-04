class AddNetpayToCompanyPayRollMaster < ActiveRecord::Migration
  def change
    add_column :company_pay_roll_masters, :total_netpay, :float
    add_column :company_pay_roll_masters, :total_tds, :float
  end
end
