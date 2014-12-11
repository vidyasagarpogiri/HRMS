class Feature < ActiveRecord::Base
  
  has_many :packages
  has_many :roles, through: :packages
end
