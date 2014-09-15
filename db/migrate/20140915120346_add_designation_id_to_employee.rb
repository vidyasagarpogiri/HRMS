class AddDesignationIdToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :designation_id, :integer
  end
end
