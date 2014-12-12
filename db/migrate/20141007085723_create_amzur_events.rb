class CreateAmzurEvents < ActiveRecord::Migration
  def change
    create_table :amzur_events do |t|
      t.string :title
      t.text :description
      t.string :held_on
      t.references :eventable, polymorphic: true
      t.boolean :is_send_mail

      t.timestamps
    end
  end
end
