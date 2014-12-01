class Post < ActiveRecord::Base

include Bootsy::Container
has_many :comments, as: :commentable
has_many :likes, as: :likeable
belongs_to :employee
end
