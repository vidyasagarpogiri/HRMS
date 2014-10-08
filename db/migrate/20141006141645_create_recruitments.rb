class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.string :jobcode
      t.string :title
      t.text :description
      t.text :link

      t.timestamps
    end
  end
end
