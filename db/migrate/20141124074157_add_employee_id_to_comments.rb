class AddEmployeeIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :employee_id, :integer
  end
end
