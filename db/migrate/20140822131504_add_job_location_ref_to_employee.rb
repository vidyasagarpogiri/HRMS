class AddJobLocationRefToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :job_location, index: true
  end
end
