class AddHeldTimeToAmzurEvent < ActiveRecord::Migration
  def change
    add_column :amzur_events, :from_time, :time
    add_column :amzur_events, :to_time, :time
  end
end
