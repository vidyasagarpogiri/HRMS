class AddStatusToLeaveHistory < ActiveRecord::Migration
  def change
    add_column :leave_histories, :status, :string
		add_column :reporting_managers, :group_id, :integer
		add_column :leave_histories, :subject, :string
  end
end
