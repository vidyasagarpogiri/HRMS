class Announcement < ActiveRecord::Base
  include Bootsy::Container
  validates :title, presence: true
  validates :description, presence: true
  
end
