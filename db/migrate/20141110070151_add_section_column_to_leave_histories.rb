class AddSectionColumnToLeaveHistories < ActiveRecord::Migration
  def change
    add_column :leave_histories, :is_halfday, :boolean, :default => false
    add_column :leave_histories, :days, :float
    add_column :leave_histories, :section, :string
  end
end
