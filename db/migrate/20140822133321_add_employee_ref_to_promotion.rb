class AddEmployeeRefToPromotion < ActiveRecord::Migration
  def change
    add_reference :promotions, :employee, index: true
  end
end
