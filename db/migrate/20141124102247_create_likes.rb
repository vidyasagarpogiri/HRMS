class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.boolean :is_like
      t.integer :employee_id
      t.timestamps
    end
  end
end
