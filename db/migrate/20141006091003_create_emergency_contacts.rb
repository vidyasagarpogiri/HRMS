class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|
      t.string :name
      t.string :relation
      t.string :mobile1
      t.string :mobile2

      t.timestamps
    end
  end
end
