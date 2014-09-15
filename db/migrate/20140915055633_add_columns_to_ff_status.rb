class AddColumnsToFfStatus < ActiveRecord::Migration
  def change
		add_column :ff_statuses, :date_of_exit, :string
		add_column :ff_statuses, :interview_status, :string
		add_column :ff_statuses, :summary, :text
		remove_column :employees, :date_of_exit, :string
  end
end
