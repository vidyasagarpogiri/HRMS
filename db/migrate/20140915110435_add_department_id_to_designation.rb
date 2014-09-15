class AddDepartmentIdToDesignation < ActiveRecord::Migration
  def change
    add_column :designations, :department_id, :integer
  end
end
