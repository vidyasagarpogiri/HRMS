class AddEmployeeRefToEducation < ActiveRecord::Migration
  def change
    add_reference :educations, :Employee, index: true
  end
end
