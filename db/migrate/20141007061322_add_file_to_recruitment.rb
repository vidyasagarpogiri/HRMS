class AddFileToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :file, :string
  end
end
