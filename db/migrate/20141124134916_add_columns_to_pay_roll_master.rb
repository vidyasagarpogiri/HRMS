class AddColumnsToPayRollMaster < ActiveRecord::Migration
  def change
    add_column :pay_roll_masters, :net_taxable_income, :float
    add_column :pay_roll_masters, :income_tax, :float
    add_column :pay_roll_masters, :education_cess, :float
    add_column :pay_roll_masters, :higher_education_cess, :float
    add_column :pay_roll_masters, :total_tax, :float
    add_column :pay_roll_masters, :status, :string
  end
end
