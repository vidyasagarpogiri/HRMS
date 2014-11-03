class AddJobTypeToRecruitments < ActiveRecord::Migration
  def change
  add_column :recruitments, :job_type, :string
  end
end
