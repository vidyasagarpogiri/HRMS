class AddEmploymentStatusToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :employment_status, :string
  end
end
