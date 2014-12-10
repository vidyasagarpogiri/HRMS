class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :description
      t.references :announceable, polymorphic: true
      t.boolean :is_send_mail
      t.timestamps
    end
  end
end
