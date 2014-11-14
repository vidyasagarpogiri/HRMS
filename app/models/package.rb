class Package < ActiveRecord::Base
  belongs_to :role
  belongs_to :feature
end
