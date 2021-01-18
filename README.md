# bridges
Simple web application that solves the bridges and torches problem.

## Rough Implementation Plan: ##
- [x] Determine Language/Framework
- [x] Set Up Barebones Local Application
- [x] Create git repo
- [x] Deploy Barebones Application to remote instance 
  - [x] Use Mina to create folder structure/ deploy code
  - [ ] Set up systemctl service to run unicorn [BLOCKED, potentially by root access?]
  - [ ] Set up nginx [skipping for now]
- [x] Q/A Barebones Application behavior on remote instance
- [x] Implement Bridge/Traveler/Trip models
- [ ] ~~Implement Basic JSON I/O Controller/View~~ (decided not to implement)
- [x] Implement Bridge&Torch Time algorithm
- [ ] ~~Create better UI to dynamically build JSON~~ (decided not to implement)
- [x] Implement Dyanamic ERB views (CRUD)

### Stretch Goals: ###
- [ ] Full Unit Testing
- [ ] Bridge Visualization


## Local Setup Instructions ##

Project Prerequisits:
- ruby 2.7.2, I recommend using RVM to manage ruby installs: https://rvm.io/
- yarn (latest), https://classic.yarnpkg.com/en/docs/install/#debian-stable
- bundler, https://bundler.io/


### Server Start: ###
- bundle install
- yarn
- npm install
- rake db:migrate
- rails s

Navigate to http://127.0.0.1:3000/trips/


