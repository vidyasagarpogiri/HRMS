class AddBankDetailsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :bank_name, :string
    add_column :employees, :branch_name, :string
    add_column :employees, :account_number, :string
  end
end
