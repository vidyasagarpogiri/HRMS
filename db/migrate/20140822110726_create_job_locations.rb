class CreateJobLocations < ActiveRecord::Migration
  def change
    create_table :job_locations do |t|

      t.timestamps
    end
  end
end
