class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.string :qualification_name

      t.timestamps
    end
  end
end
