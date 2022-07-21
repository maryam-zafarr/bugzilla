# Bugzilla
Bugzilla is a bug tracking system that:
  - Allows managers to create projects and add developers and qa to project teams.
  - Allows qa engineers ti report bugs to projects, and
  - Allows developers to assign bugs from a list of their projects.

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
