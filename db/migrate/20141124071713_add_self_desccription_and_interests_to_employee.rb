class AddSelfDesccriptionAndInterestsToEmployee < ActiveRecord::Migration
  def change
  add_column :employees, :self_description, :text
  add_column :employees, :interests, :text
  end
end
