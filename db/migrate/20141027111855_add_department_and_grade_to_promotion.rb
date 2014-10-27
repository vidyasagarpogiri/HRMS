class AddDepartmentAndGradeToPromotion < ActiveRecord::Migration
  def change
    add_column :promotions, :department_id, :integer
    add_column :promotions, :grade_id, :integer
  end
end
