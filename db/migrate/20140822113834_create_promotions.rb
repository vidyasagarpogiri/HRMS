class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.date :date_of_promotion

      t.timestamps
    end
  end
end
