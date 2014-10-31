class RenameDecriptionToDescriptionInGeneralInvestments < ActiveRecord::Migration
  def change
    rename_column :general_investments, :decription, :description
  end
end
