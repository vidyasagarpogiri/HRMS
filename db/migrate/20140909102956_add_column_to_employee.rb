class AddColumnToEmployee < ActiveRecord::Migration
  def change
		add_column :employees, :alternate_email, :string
  end
end
