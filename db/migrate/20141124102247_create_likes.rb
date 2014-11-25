class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :is_like
      t.integer :employee_id
      t.integer :status_id

      t.timestamps
    end
  end
end
