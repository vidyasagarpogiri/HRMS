class ChangeStatusIdToComments < ActiveRecord::Migration
  def change
    change_column :comments, :status_id, :integer
  end
end
