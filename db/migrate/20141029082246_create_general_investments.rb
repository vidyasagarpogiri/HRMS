class CreateGeneralInvestments < ActiveRecord::Migration
  def change
    create_table :general_investments do |t|
      t.string :title
      t.text :decription
      t.integer :section_declaration_id

      t.timestamps
    end
  end
end
