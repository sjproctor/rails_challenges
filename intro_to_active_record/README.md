# Intro to Active Record

## Process

### Setup
- rails new intro_to_active_record -d postgresql -T
- cd intro_to_active_record
- rails db:create

### Challenge: Create, Update, Insert, DELETE with ActiveRecord and Rails c

- Create an Rails app named 'rolodex'
- Run `rails db:create` to setup your database
- Create a persons model with a first_name, last_name, and phone. All fields should be strings. You can use migrations to do this
  - run `bundle exec rails generate migration CreateContacts`
    - creates a file called db/migrate/create_persons.rb:
      ```ruby
      class CreatePersons < ActiveRecord::Migration[6.0]
        def change
          create_table :persons do |t|
          end
        end
      end
      ```
    - add the information needed to create a table
      ```ruby
      class CreatePersons < ActiveRecord::Migration[6.0]
        def create
          create_table :persons do |t|
            t.string :first_name
            t.string :last_name
            t.string :phone
          end
        end
      end
      ```
- Run rails db:migrate from the command line
  - run `bundle exec rails db:migrate`
  - this creates a file in the migrate directory called `schema.rb`
- Open up Rails console
  - loads `irb(main):001:0>`
- Add five or more family members to the persons table.
How many have the same last_name as you? (Look up the information using ActiveRecord queries)
Add yourself into the persons table.
Update all family members with the same last_name as you to have the same phone number as you.
Delete all family members not with your last_name.
