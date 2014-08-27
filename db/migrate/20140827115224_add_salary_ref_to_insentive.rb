class AddSalaryRefToInsentive < ActiveRecord::Migration
  def change
    add_reference :insentives, :salary, index: true
  end
end
