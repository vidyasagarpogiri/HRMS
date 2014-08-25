class AddEducationRefToEducationQualification < ActiveRecord::Migration
  def change
    add_reference :education_qualifications, :education, index: true
  end
end
