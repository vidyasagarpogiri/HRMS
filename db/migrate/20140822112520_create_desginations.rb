class CreateDesginations < ActiveRecord::Migration
  def change
    create_table :desginations do |t|
      t.string :desgination_name

      t.timestamps
    end
  end
end
