class AddDeviseIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :devise_id, :string
  end
end
