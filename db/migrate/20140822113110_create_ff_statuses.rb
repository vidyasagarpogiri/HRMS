class CreateFfStatuses < ActiveRecord::Migration
  def change
    create_table :ff_statuses do |t|
      t.string :status_name

      t.timestamps
    end
  end
end
