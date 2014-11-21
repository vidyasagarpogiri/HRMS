class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :controller
      t.string :action
      t.text :description

      t.timestamps
  end
 end
end
