class AddColumnsToAddress < ActiveRecord::Migration
  def change
		add_column :addresses, :city, :string
		add_column :addresses, :state, :string
		add_column :addresses, :country, :string
		add_column :addresses, :zipcode, :string
		remove_column :addresses, :city_id, :integer
		remove_column :addresses, :state_id, :integer
		remove_column :addresses, :country_id, :integer
  end
end
