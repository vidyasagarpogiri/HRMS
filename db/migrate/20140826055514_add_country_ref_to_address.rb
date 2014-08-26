class AddCountryRefToAddress < ActiveRecord::Migration
  def change
    add_reference :addresses, :country, index: true
  end
end
