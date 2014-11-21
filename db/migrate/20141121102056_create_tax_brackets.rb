class CreateTaxBrackets < ActiveRecord::Migration
  def change
    create_table :tax_brackets do |t|
      t.string :bracket
      t.float :lower_limit
      t.float :upper_limit
      t.integer :tax_percentage
      t.float :min_tax

      t.timestamps
    end
  end
end
