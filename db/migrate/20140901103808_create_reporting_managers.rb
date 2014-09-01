class CreateReportingManagers < ActiveRecord::Migration
  def change
    create_table :reporting_managers do |t|
      t.integer :department_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
