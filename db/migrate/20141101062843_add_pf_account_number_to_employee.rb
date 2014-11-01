class AddPfAccountNumberToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :PFAccountNumber, :string
  end
end
