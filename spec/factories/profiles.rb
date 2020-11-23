FactoryBot.define do
  factory :profile do
    first_name { "Admin" }
    last_name { "Colgate" }
    pronouns { "they/them/theirs" }
    class_year { 2021 }
    majors { "Computer Science" }
    minors { "English" }
    interests { "Dance" }
    status { "No status to share" }
    account factory: :account, email: "admin@colgate.edu", password: "colgate13"
  end
end
