class AddDesignationRefToPromotion < ActiveRecord::Migration
  def change
    add_reference :promotions, :designation, index: true
  end
end
