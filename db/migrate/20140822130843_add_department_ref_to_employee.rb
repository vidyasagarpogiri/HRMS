class AddDepartmentRefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :department, index: true
  end
end
