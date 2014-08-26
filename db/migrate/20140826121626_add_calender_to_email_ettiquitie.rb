class AddCalenderToEmailEttiquitie < ActiveRecord::Migration
  def change
    add_column :email_ettiquities, :dateofsending, :date
  end
end
