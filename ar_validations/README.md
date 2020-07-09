## Rails Active Record Validations Account Challenge

### Stories for Account:
- As a developer, I need to generate a model called Account that has a username, a password, and an email (done)
$ rails new account_challenge -d postgresql -T
$ rails db:create
$ rails generate model Account username:string password:string email:string
$ rails db:migrate

- As a developer, I need username, password, and email to be required (done)
*app/models/account.rb*
```
class Account < ApplicationRecord
  validates :username, :password, :email, presence: true
end
```
- As a developer, I need every username to be at least 5 characters long (done)
`validates :username, length: { minimum: 5 }`

- As a developer, I need each username to be unique (done)
`validates :username, uniqueness: true`

- As a developer, I need each password to be at least 6 characters long (done)
`validates :password, length: { minimum: 6 }`

- As a developer, I need each password to be unique (done)
`validates :password, uniqueness: true`


### Stories for Address:
- As a developer, I want my Account model to have many associated Addresses (done)

- As a developer, I want Address to have street_number, street_name, city, state, and zip attributes (done)
`rails generate model Address street_number:string street_name:string city:string state:string zip:string account_id:integer`

- As a developer, I want to validate all fields on Address (done)
`validates :street_number, :street_name, :city, :state, :zip, presence: true`

### Stretch Challenges
Implementing [Custom Validations](https://guides.rubyonrails.org/active_record_validations.html#performing-custom-validations):

- As a developer, I need each Account password to have at least one number
- As a developer, I need each Account password to have at least one special character
- As a developer, I want to validate that Address street_number, street_name, zip are unique for within an account
	- **Hint:** Read about :scope in the Rails validation docs
- As a developer, I want to validate associated addresses on accounts
	- **Hint:** Read about validates_associated in the Rails validation docs




a = Account.create username: "Not valid"
a.errors.any? (returns a boolean)
a.valid? (returns a boolean)
a.error.full_messages
