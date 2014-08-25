class AddBloodGroupRefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :blood_group, index: true
  end
end
