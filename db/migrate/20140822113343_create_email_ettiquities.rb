class CreateEmailEttiquities < ActiveRecord::Migration
  def change
    create_table :email_ettiquities do |t|
      t.text :ettiquite

      t.timestamps
    end
  end
end
