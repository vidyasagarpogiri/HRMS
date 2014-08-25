class AddQualificationRefToEducationQualification < ActiveRecord::Migration
  def change
    add_reference :education_qualifications, :qualification, index: true
  end
end
