class AddRoles < ActiveRecord::Migration
  def change
    puts "Creating Roles"
    Designation.all.each do |desg|
      Role.create(department_id: desg.department.id, designation_id: desg.id)
    end
  end
end
