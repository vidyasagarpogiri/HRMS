class AddAttachmentNameToEmployeeAttachment < ActiveRecord::Migration
  def change
    add_column :employee_attachments, :attachment_name, :string
  end
end
