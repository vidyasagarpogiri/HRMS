class AddDesignationRefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :designation, index: true
  end
end
