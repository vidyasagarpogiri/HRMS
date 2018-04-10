class Designation < ActiveRecord::Base
                                              
  belongs_to :departmnet                                                                
  has_many :employees                               
  has_many :promotions                                                            
  has_many :grades                                                                                                                                                                                                  
                                                                             
  validates :designation_name, presence: true, uniqueness: { case_sensitive: false }
  
end           
