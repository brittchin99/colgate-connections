# Colgate Connections
Colgate Connections is a social application created for students at Colgate University as part of COSC415 - Software Engineering.

![Colgate Connections Logo](https://drive.google.com/uc?export=view&id=1_i6jORkHwudb1-phZF4iBm2RIqaIsEff)

Heroku Link: https://limitless-springs-65918.herokuapp.com/ 

## Motivation
Colgate Connections is designed to connect Colgate students during Covid-19. As most on-campus events have been moved to a virtual platform, it has become harder to make new friends and meet new people. Colgate Connections aims to overcome this social barrier by allowing students to find others with similar interests in a fun, Colgate-specific way.

## Minimum Viable Product (MVP)
* Create profile (sign up)
* Update profile
* Log In
* View profile
* Message student
* Suggested connections
* Search students (and filter)
* “Connect” with other student (similar to “following”, connections are mutual, add to “My Connections”)

## System Requirements
* Ruby version of at least 2.5.3
* Rails version of at least 5.2.3

After cloning, run `bundle install —without production` to get the latest gems.

Configure the database by running
```
rails db:migrate
rails db:seed
rails db:test:prepare
```

## Usage
### Development Server
Run `rails server`, then go to http://localhost:3000.

### Production
Create an app in heroku using `heroku create <app name>`.
Then in your terminal run `heroku run rails db:migrate && heroku run rails db:seed`.

## License
colgate-connections © 2020 Brittney Chin, Emily Cruz Gonzalez, Amber Nguyen, Nhiem Ngo, and Si Wei
