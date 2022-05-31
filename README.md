#  ossdatabase ⚡️

![Tests](https://github.com/prithvi16/ossdatabase/actions/workflows/workflow.yml/badge.svg)


This is the source for ossdatabase.com 🚀. OssDatabse is a database of open source software alternatives for proprietary software. The project is built using Ruby on Rails. 

## Features
 - Search for open-source projects
 - Submit open-source projects
 - View alternative open-source projects


## Local development setup

### Requiremnts for local development

Install the dependencies for local development

```
Ruby 2.7.1
Node 12.21.0
Yarn 1.21.1
Redis
PostgreSQL
```
### Clone code
  
``` 
git clone git@github.com:prithvi16/ossdatabase.git
cd ossdatabase
bundle install
yarn
```
### Configure database
  
  ```
  cp .env.example .env
  ```
Add your local postgresql username and password to .env
### Setup the database

```
rails db:create
rails db:migrate
rails db:seed
```

### Run server
  
  ```
  gem install foreman
  foreman start -f Procfile.dev
  ```

### Runs specs
  
  ```
  bundle exec rspec
  ```

## Liscence 
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)