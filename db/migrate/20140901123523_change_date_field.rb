class ChangeDateField < ActiveRecord::Migration
  def change
		change_column :employees, :date_of_birth, :string
		change_column :employees, :date_of_confirmation, :string
		change_column :employees, :date_of_join, :string
		change_column :experiences, :from_date, :string
		change_column :experiences, :to_date, :string
		change_column :educations, :year_of_admission, :string
		change_column :educations, :year_of_pass, :string
		change_column :email_ettiquities, :dateofsending, :string
		change_column :promotions, :date_of_promotion, :string
		change_column :salary_increments, :increment_date, :string
  end
end
