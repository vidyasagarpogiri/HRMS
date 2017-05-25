class Promotion < ActiveRecord::Base             
  belongs_to :employee                                                              
  belongs_to :designation                                                                      
  validates :date_of_promotion, presence: true
  validates :designation_id, presence: true
end
