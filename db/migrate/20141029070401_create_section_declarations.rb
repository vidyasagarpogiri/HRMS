class CreateSectionDeclarations < ActiveRecord::Migration
  def change
    create_table :section_declarations do |t|
      t.string :section
      t.float :maximum_limit

      t.timestamps
    end
  end
end
