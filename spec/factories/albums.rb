FactoryGirl.define do
  factory :album do
    title "Myalbum"
    description "B'day party pics"
    employee_id 1
  end

  factory :invalid_album , parent: :album do
    title nil
    description nil
    employee_id nil
  end
  
  factory :invalid_title_album , parent: :album do
    title nil
    description "qqq"
    employee_id 1
  end
  
  factory :invalid_description_album , parent: :album do
    title "Album"
    description nil
    employee_id 1
  end
  
  factory :invalid_id_album , parent: :album do
    title "Album"
    description "qqq"
    employee_id nil
  end
  
end
