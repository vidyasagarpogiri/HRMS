class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :tags
      t.integer :employee_id
      t.string :category

      t.timestamps
    end
  end
end
