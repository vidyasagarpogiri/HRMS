class AddStatusToAppraisal < ActiveRecord::Migration
  def change
    add_column :appraisals, :status, :string
    add_column :appraisals, :is_assign, :boolean, :default => false
  end
end
