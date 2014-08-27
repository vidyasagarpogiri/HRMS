class AddSalaryRefToSalaryIncrement < ActiveRecord::Migration
  def change
    add_reference :salary_increments, :salary, index: true
  end
end
