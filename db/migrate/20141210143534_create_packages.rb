class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :role_id
      t.integer :feature_id
      t.timestamps
    end
  end
end
