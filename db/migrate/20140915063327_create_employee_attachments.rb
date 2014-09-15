class CreateEmployeeAttachments < ActiveRecord::Migration
  def change
    create_table :employee_attachments do |t|
      t.integer :employee_id
      t.string :attachment

      t.timestamps
    end
  end
end
