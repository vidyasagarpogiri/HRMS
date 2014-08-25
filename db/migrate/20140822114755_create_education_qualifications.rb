class CreateEducationQualifications < ActiveRecord::Migration
  def change
    create_table :education_qualifications do |t|

      t.timestamps
    end
  end
end
