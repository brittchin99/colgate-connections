# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Account.delete_all
Profile.delete_all
    
amber = Account.create!(:email => 'ptnguyen@colgate.edu', :admin => false, :password => "colgate13")
amber.profile = Profile.new(:first_name => "Amber", :last_name => "Nguyen",
    :pronouns => "she/her/hers", :class_year => 2021, :majors => ["Computer Science", "Economics"], :minors => "Japanese", :interests => "Anime")

emily = Account.create!(:email => 'ecruzgonzalez@colgate.edu', :admin => false, :password => "colgate13")
emily.profile = Profile.new(:first_name => "Emily", :last_name => "Cruz Gonzalez",
    :pronouns => "she/her/hers", :class_year => 2021, :majors => ["Computer Science", "English"], :minors => "Anthropology", :interests => "Anime")

britt = Account.create!(:email => 'bchin@colgate.edu', :admin => false, :password => "colgate13")
britt.profile = Profile.new(:first_name => "Brittney", :last_name => "Chin",
    :pronouns => "she/her/hers", :class_year => 2021, :majors => "Computer Science", :minors => ["LGBTQ Studies", "Educational Studies"], :interests => "Performing Arts")

si = Account.create!(:email => 'swei@colgate.edu', :admin => false, :password => "colgate13")
si.profile = Profile.new(:first_name => "Si", :last_name => "Wei",
    :pronouns => "she/her/hers", :class_year => 2021, :majors => ["Computer Science", "International Relations"], :interests => "Sports and Athletics")

admin = Account.create!(:email => 'admin@colgate.edu', :admin => true, :password => "colgate13")
admin.profile = Profile.new(:first_name => "Admin", :last_name => "Colgate",
    :pronouns => "they/them/theirs", :class_year => 2021, :majors => "Computer Science", :minors => "English", :interests => "Dance", :status => "No status to share")

admin.profile.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'raider.jpg')), filename: 'raider.jpg')
admin.profile.photos.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'raider1.png')), filename: 'raider1.png')
admin.profile.photos.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'raider2.png')), filename: 'raider2.png')
admin.profile.photos.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'raider3.png')), filename: 'raider3.png')
admin.profile.photos.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'raider4.png')), filename: 'raider4.png')