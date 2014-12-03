class CreateWorkgroups < ActiveRecord::Migration
  def change
    create_table :workgroups do |t|
      t.string :name
      t.text :description
      t.string :avatar
      t.integer :admin_id

      t.timestamps
    end
  end
end
