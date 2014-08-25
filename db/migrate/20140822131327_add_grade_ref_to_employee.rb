class AddGradeRefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :grade, index: true
  end
end
