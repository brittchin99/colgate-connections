FactoryBot.define do
  factory :profile do
    first_name { "MyString" }
    last_name { "MyString" }
    string { "MyString" }
    pronouns { "MyString" }
    class_year { 1 }
    majors { "MyText" }
    minors { "MyText" }
    interests { "MyText" }
    status { "MyText" }
  end
end
