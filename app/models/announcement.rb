class Announcement < ActiveRecord::Base
  belongs_to :announceable, polymorphic: true
  include Bootsy::Container
  validates :title, presence: true
  #validates :description, presence: true
  
end
