class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :title
      t.text :details
      t.string :document

      t.timestamps
    end
  end
end
