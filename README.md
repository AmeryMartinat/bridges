# bridges
Simple web application that solves the bridges and torches problem.

Rough Implementation Plan:
- [x] Determine Language/Framework
- [x] Set Up Barebones Local Application
- [x] Create git repo
- [x] Deploy Barebones Application to remote instance 
  - [x] Use Mina to create folder structure/ deploy code
  - [ ] Set up systemctl service to run unicorn [BLOCKED, potentially by root access?]
  - [ ] Set up nginx [skipping for now]
- [x] Q/A Barebones Application behavior on remote instance
- [ ] Implement Bridge/Traveler/Trip models
- [ ] Implement Basic JSON I/O Controller/View
- [ ] Implement Bridge&Torch Time algorithm
- [ ] Create better UI to dynamically build JSON

Stretch Goals:
- [ ] Full Unit Testing
- [ ] Bridge Visualization


Intial Algorithm Thoughts:
* Not sure if travelers picked up at a given bridge are added to the party permanently or just for that bridge.
* Will implement a solution for the permanent case with a checkbox to toggle this behavior (time allowing)
* Not sure if attempting recursive solution or hardcoded. 
