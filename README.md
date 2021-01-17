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
- [x] Implement Bridge/Traveler/Trip models
- [ ] Implement Basic JSON I/O Controller/View
- [x] Implement Bridge&Torch Time algorithm
- [ ] Create better UI to dynamically build JSON

Stretch Goals:
- [ ] Full Unit Testing
- [ ] Bridge Visualization
