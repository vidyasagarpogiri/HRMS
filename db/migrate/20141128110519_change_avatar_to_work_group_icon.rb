class ChangeAvatarToWorkGroupIcon < ActiveRecord::Migration
  def change
    rename_column :workgroups, :avatar, :workgroupicon
  end
end
