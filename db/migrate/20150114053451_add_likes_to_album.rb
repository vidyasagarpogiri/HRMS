class AddLikesToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :likes_count, :integer, :default => 0
  end
end
