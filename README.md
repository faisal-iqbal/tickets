# SPA Ticketing System

* Ruby version 2.3.0
* Rails version 5.0.0.1

Installation
  Run:
    bundle install
    rake db:create
    rake db:migrate
    rake db:seed

User Accounts:
  If seed data is sucessfuly loaded. Following user accounts would be present:
  Normal User:
    email: 'normal@example.com', password: 'password'
  Support User:
    email: 'support@example.com', password: 'password'
  Admin User:
    email: 'admin@example.com', password: 'password'

Assumptions:
  Normal User:
    1. can see all previous tickets
    2. can close the ticket
    3. can add comments to tickets

  Support User:
    1. can see all previous tickets
    2. can assign ticket to himself
    3. can close the ticket
    4. can add comments to tickets

  Admin User:
    1. can see all previous tickets
    2. can assign ticket to other users
    3. can close the ticket
    4. can delete tickets
    5. can add comments to tickets
    6. can delete comments
    7. can see all users
    8. can delete users
    9. can change user roles for non admin users

