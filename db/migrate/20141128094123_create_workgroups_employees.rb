class CreateWorkgroupsEmployees < ActiveRecord::Migration
  def change
    create_table :workgroups_employees do |t|
      t.integer :employee_id
      t.integer :workgroup_id
      t.boolean :is_moderator

      t.timestamps
    end
  end
end
