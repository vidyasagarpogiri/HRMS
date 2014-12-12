class CreateAppraisals < ActiveRecord::Migration
  def change
    create_table :appraisals do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
