# Rails application
# Stack
* Ruby - 2.2
* rails - 3.2

# Getting started
To get the Rails server running locally:

- Clone this repo
- `bundle install` to install all req'd dependencies
- `rake db:create` to create database
- `rake db:migrate` to make all database migrations
- `rails s` to start the local server

**Note** : If you want some data be loaded initially run `rake db:seed`

## Gems used

- [kaminari](https://github.com/kaminari/kaminari) - For implementing pagination
- [sidekiq](https://github.com/mperham/sidekiq) - For implementing background jobs
- [smarter_csv](https://github.com/tilo/smarter_csv) and [carrierwave](https://github.com/carrierwaveuploader/carrierwave) - For implementing csv import functionality
- [factory_girl_rails](https://github.com/dscape/factory_girl_rails) and [faker](https://github.com/stympy/faker) - For implementing test cases

## Folders

- `app/models` - Contains the database models for the application where we can define methods, validations, queries, and relations to other models.
- `app/views` - Contains templates for generating the JSON output for the API
- `app/controllers` - Contains the controllers where requests are routed to their actions, where we find and manipulate our models and return them for the views to render.
- `config` - Contains configuration files for our Rails application and for our database, along with an `initializers` folder for scripts that get run on boot.
- `db` - Contains the migrations needed to create our database schema.
