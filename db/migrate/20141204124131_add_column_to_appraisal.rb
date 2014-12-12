class AddColumnToAppraisal < ActiveRecord::Migration
  def change
    add_column :employees_appraisal_lists, :title, :string
    add_column :employees_appraisal_lists, :description, :text
    add_column :employees_appraisal_lists, :discussion_notes, :text
    add_column :employees_appraisal_lists, :start_date, :date
    add_column :employees_appraisal_lists, :end_date, :date
    add_column :employees_appraisal_lists, :review_period, :string
  end
end
