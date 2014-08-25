class AddEmployeeRefToEmailEttiquitie < ActiveRecord::Migration
  def change
    add_reference :email_ettiquities, :employee, index: true
  end
end
