class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :employee_is
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :date_of_birth
      t.string :gender
      t.string :marital_status
      t.float :total_experience
      t.boolean :status
      t.string :mobile_number
      t.string :father_name
      t.string :pan
      t.string :date_of_confirmation
      t.string :date_of_join
      t.string :date_of_exit
      t.text :image_url

      t.timestamps
    end
  end
end
