class City < ActiveRecord::Base
  belongs_to :states
  has_many :addresses
  has_many :educations
end
