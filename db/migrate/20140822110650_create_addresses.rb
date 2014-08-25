class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :line1
      t.text :line

      t.timestamps
    end
  end
end
