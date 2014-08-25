class AddAddressrefToJobLocation < ActiveRecord::Migration
  def change
    add_reference :job_locations, :address, index: true
  end
end
