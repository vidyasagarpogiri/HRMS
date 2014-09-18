class AddDepartmentIdToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :designation_id, :integer
  end
end
