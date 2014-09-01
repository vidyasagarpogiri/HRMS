class AddColumnsToAddress < ActiveRecord::Migration
  def change
		add_column :addresses, :city, :string
		add_column :addresses, :state, :string
		add_column :addresses, :country, :string
		add_column :addresses, :zipcode, :string
		
  end
end
