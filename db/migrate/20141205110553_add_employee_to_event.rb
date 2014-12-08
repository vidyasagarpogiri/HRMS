class AddEmployeeToEvent < ActiveRecord::Migration
  def change
   add_column :amzur_events, :employee_id, :integer
  end
end
