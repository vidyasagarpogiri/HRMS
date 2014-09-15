class AddMangerIdToReportingManager < ActiveRecord::Migration
  def change
    	add_column :reporting_managers, :manager_id, :integer
  end
end
