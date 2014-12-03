class Post < ActiveRecord::Base
searchable do
    text :title, :content, :tags, :category
end

include Bootsy::Container
has_many :comments, as: :commentable
has_many :likes, as: :likeable
belongs_to :employee
end
