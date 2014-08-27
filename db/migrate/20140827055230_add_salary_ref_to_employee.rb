class AddSalaryRefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :salary, index: true
  end
end
