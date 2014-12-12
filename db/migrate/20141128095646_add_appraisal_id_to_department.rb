class AddAppraisalIdToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :appraisal_id, :integer
  end
end
