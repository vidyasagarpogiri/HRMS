class AddStatustoRecruitment < ActiveRecord::Migration
  def change
     add_column :recruitments, :status, :string
  end
end
