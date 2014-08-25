class CreateRolePreviliges < ActiveRecord::Migration
  def change
    create_table :role_previliges do |t|
      t.text :previlige_url
      t.text :user_interface_url
      t.text :image_url

      t.timestamps
    end
  end
end
