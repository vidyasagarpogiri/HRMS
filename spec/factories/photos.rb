FactoryGirl.define do
  factory :photo do
    image "MyString.jpg"
    album_id 1
    #assosiation :albums, factory: :albums
  end
end
