# Bugzilla
Bugzilla is a bug tracking system that:
  - Allows managers to create projects and add developers and qa to project teams.
  - Allows qa engineers to report bugs to projects, and
  - Allows developers to assign bugs from a list of their projects.

## Built With
 - Ruby on Rails
 - Bootstrap 4
 - Postgresql
 - Devise gem
 - Pundit gem
 
## Getting Started
Before starting, please ensure that your system meets the following software requirements:
  - Ruby 2.7.0
  - Rails 5.2.0 (5.2.8 is recommended)
  - Postgres 14+

## Installation

### Clone the repository
```
git clone https://github.com/maryam-zafarr/bugzilla.git
cd bugzilla
```

### Install dependencies
```
bundle install
```

### Initialize the database
```
rails db:create
rails db:seed
```

### Serve
```
rails s
```

## Features

#### Manager
 - Create a project
 - Edit and Delete the projects he creates.
 - Add/Remove Developers and QAs to the projects he creates

#### Developer
 - Assign bugs to himself. Pick up a bug from the list of his projects. 
 - Can see only the projects he is part of. 
 - Mark a bug resolved. 
 - Can not see other projects. 
 - Can not report Bug. 
 - Can not delete a Bug. 
 - Can not join any project

#### QA
- Report Bugs to all projects
- Can see all projects.
- Can not edit/delete/create any project.


