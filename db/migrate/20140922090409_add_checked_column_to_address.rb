class AddCheckedColumnToAddress < ActiveRecord::Migration
  def up  
    add_column :addresses, :is_permanent, :boolean
  end
  
  def down
    remove_column :addresses, :is_permanent
  end
end
