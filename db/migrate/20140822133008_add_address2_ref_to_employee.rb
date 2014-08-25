class AddAddress2RefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :present_address, index: true
  end
end
