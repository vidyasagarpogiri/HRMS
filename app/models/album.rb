class Album < ActiveRecord::Base
  belongs_to :employee
  has_many :photos
  accepts_nested_attributes_for :photos
end
