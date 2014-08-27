class CreateInsentives < ActiveRecord::Migration
  def change
    create_table :insentives do |t|
      t.string :insentive_type
      t.float :value

      t.timestamps
    end
  end
end
