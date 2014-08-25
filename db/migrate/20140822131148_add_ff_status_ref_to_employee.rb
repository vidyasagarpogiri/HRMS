class AddFfStatusRefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :ff_status, index: true
  end
end
