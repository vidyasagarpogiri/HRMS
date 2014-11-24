class CreateTaxExemptions < ActiveRecord::Migration
  def change
    create_table :tax_exemptions do |t|
      t.string :gender
      t.float :exemption_limit

      t.timestamps
    end
  end
end
