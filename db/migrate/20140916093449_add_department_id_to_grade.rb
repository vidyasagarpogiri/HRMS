class AddDepartmentIdToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :department_id, :integer
  end
end
