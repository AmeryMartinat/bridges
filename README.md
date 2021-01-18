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
- [ ] Deplopy Finalized Application to remote instance  [BLOCKED, potentially by SSH access?]

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

### Using the App: ###
- Navigate to http://127.0.0.1:3000/trips/
- Fill out Trip data (sorry the styling is terrible, spent all of my engineering time today trying to get dynamic forms working in ERB)
  - ![edit](https://i.ibb.co/F0Vkwdq/trip-from-prompt.png)
- After save the trip time is automatically calulated and saved to the record. 
  - Updating the model recalulates and saves the new value
  - ![show](https://i.ibb.co/fXgDGN4/prompt-trip-built.png)

### Notes and Caveats: ##
- There is currently no validation on the input form and error handling in general is very limited
- My travel time calculation does not persist new travelers by default
  - I.E when travelers join at a specefic bridge, they are not "added to the party" and expected to cross the later bridges
  - If this behavior is desired for a given trip please check the "Persist Party" checkbox on /trips/new
  - If "Persist Party" is enabled, bridge order will be determined by "Bridge Number (id)"
    
