class AddColumnToDesignation < ActiveRecord::Migration
  def change
    add_column :designations, :designation_name, :string
  end
end
