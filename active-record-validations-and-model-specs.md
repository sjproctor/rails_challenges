# Active Record Validations and Model Specs Challenge
Updated: June 2021

### Setup
- Create a new rails application called 'validations'  
$ `rails new validations -d postgresql -T`  
$ `cd validations`

- Create the database  
$ `rails db:create`

- Add RSpec
$ bundle add rspec-rails  
$ rails generate rspec:install  

### Challenges
You have been tasked to set up an Account model for a your company. The application must be secure and tested.

- As a developer, I need to generate a model called Account that has a username, a password, and an email.

$ `rails generate model Account username:string password:string email:string`  
$ `rails db:migrate`

- As a developer, I need username, password, and email to be required.

*spec/models/account_spec.rb*
```ruby
RSpec.describe Account, type: :model do
  it 'is valid with valid attributes' do
    account = Account.create username: 'Michael Bluth', password: 'georgemichael4', email: 'm.bluth@mail.com'
    expect(account).to be_valid
  end
  it 'is not valid without a username' do
    account = Account.create password: 'georgemichael4', email: 'm.bluth@mail.com'
    expect(account.errors[:username]).to_not be_empty
  end
  it 'is not valid without a password' do
    account = Account.create username: 'Michael Bluth', email: 'm.bluth@mail.com'
    expect(account.errors[:password]).to_not be_empty
  end
  it 'is not valid without a email' do
    account = Account.create username: 'Michael Bluth', password: 'georgemichael4'
    expect(account.errors[:email]).to_not be_empty
  end
end
```

*app/models/account.rb*
```ruby
class Account < ApplicationRecord
  validates :username, :password, :email, presence: true
end
```

- As a developer, I need every username to be at least 5 characters long.

*spec/models/account_spec.rb*
```ruby
it 'username is not valid if less than 5 characters' do
  account = Account.create username: 'MB', password: 'georgemichael4', email: 'm.bluth@mail.com'
  expect(account.errors[:username]).not_to be_empty
end
```

*app/models/account.rb*
```ruby
class Account < ApplicationRecord
  validates :username, :password, :email, presence: true
  validates :username, length: { minimum: 5 }
end
```

- As a developer, I need each username to be unique.

*spec/models/account_spec.rb*
```ruby
it 'username must be unique' do
  Account.create username: 'Michael Bluth', password: 'georgemichael4', email: 'm.bluth@mail.com'
  account = Account.create username: 'Michael Bluth', password: 'georgemichael4', email: 'm.bluth@mail.com'
  expect(account.errors[:username]).not_to be_empty
end
```

*app/models/account.rb*
```ruby
class Account < ApplicationRecord
  validates :username, :password, :email, presence: true
  validates :username, length: { minimum: 5 }
  validates :username, uniqueness: true
end
```

- As a developer, I need each password to be at least 6 characters long.

*spec/models/account_spec.rb*
```ruby
it 'password is not valid if less than 6 characters' do
  account = Account.create username: 'Michael Bluth', password: 'gm4', email: 'm.bluth@mail.com'
  expect(account.errors[:password]).not_to be_empty
end
```

*app/models/account.rb*
```ruby
class Account < ApplicationRecord
  validates :username, :password, :email, presence: true
  validates :username, length: { minimum: 5 }
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6 }
end
```

- As a developer, I need each password to be unique.

*spec/models/account_spec.rb*
```ruby
it 'password must be unique' do
  Account.create username: 'Michael Bluth', password: 'georgemichael4', email: 'm.bluth@mail.com'
  account = Account.create username: 'Michael Bluth', password: 'georgemichael4', email: 'm.bluth@mail.com'
  expect(account.errors[:password]).not_to be_empty
end
```

*app/models/account.rb*
```ruby
class Account < ApplicationRecord
  validates :username, :password, :email, presence: true
  validates :username, length: { minimum: 5 }
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password, uniqueness: true
end
```

- As a developer, I want my Account model to have many associated Addresses. I want Address to have street_number, street_name, city, state, and zip attributes.

$ `rails generate model Address street_number:integer street_name:string city:string state:string zip:integer account_id:integer`
$ `rails db:migrate`

*app/models/address.rb*
```ruby
class Address < ApplicationRecord
  belongs_to :account
end
```

*app/models/account.rb*
```ruby
class Account < ApplicationRecord
  has_many :addresses
  validates :username, :password, :email, presence: true
  validates :username, length: { minimum: 5 }
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password, uniqueness: true
end
```

- As a developer, I want to validate the presence of all fields on Address.

*spec/models/address_spec.rb*
```ruby
RSpec.describe Address, type: :model do
  let(:account) { Account.create username: 'Michael Bluth', password: 'georgemichael4', email: 'm.bluth@mail.com' }
  it 'is valid with valid attributes' do
    address = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: account.id
    expect(address).to be_valid
  end
  it 'must have a valid account' do
    invalid_account = Account.create
    address = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: invalid_account.id
    expect(address).to_not be_valid
  end
  it 'is not valid without a street_number' do
    address = Address.create street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: account.id
    expect(address.errors[:street_number]).to_not be_empty
  end
  it 'is not valid without a street_name' do
    address = Address.create street_number: 1234, city: 'Newport Beach', state: 'CA', zip: 92603, account_id: account.id
    expect(address.errors[:street_name]).to_not be_empty
  end
  it 'is not valid without a city' do
    address = Address.create street_number: 1234, street_name: 'Sudden Valley Way', state: 'CA', zip: 92603, account_id: account.id
    expect(address.errors[:city]).to_not be_empty
  end
  it 'is not valid without a state' do
    address = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', zip: 92603, account_id: account.id
    expect(address.errors[:state]).to_not be_empty
  end
  it 'is not valid without a zip' do
    address = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', account_id: account.id
    expect(address.errors[:zip]).to_not be_empty
  end
end
```

*app/models/address.rb*
```ruby
class Address < ApplicationRecord
  belongs_to :account
  validates :street_number, :street_name, :city, :state, :zip, presence: true
end
```

### Stretch Challenges

- As a developer, I need each Account password to have at least one number.

*spec/models/account_spec.rb*
```ruby
it 'password must have at least one number' do
  account = Account.create username: 'Michael Bluth', password: 'georgemichael', email: 'm.bluth@mail.com'
  expect(account.errors[:password]).not_to be_empty
end
```

*app/models/account.rb*
```ruby
class Account < ApplicationRecord
  has_many :addresses
  validates :username, :password, :email, presence: true
  validates :username, length: { minimum: 5 }
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password, uniqueness: true
  validate :password_must_exist_and_contain_a_number

  def password_must_exist_and_contain_a_number
    if password.nil?
      errors.add(:password, 'must be present')
    else
      errors.add(:password, 'must contain at least one digit') unless password.match(/[0-9]/)
    end
  end
end
```

- As a developer, I want to validate that Address street_number, street_name, zip are unique for within an account. Hint: Read about :scope in the Rails validation docs.

*spec/models/address_spec.rb*
```ruby
it 'must be unique within an account' do
  address1 = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: account.id
  address2 = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: account.id
  expect(address2).to_not be_valid
  expect(address2.errors[:street_name].first).to eq 'account data must be unique'
  expect(address2.errors[:street_number].first).to eq 'account data must be unique'
  expect(address2.errors[:city].first).to eq 'account data must be unique'
  expect(address2.errors[:state].first).to eq 'account data must be unique'
  expect(address2.errors[:zip].first).to eq 'account data must be unique'
end
end
it 'addresses can be repeated in unique accounts' do
  address1 = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: account.id
  address2 = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: second_account.id
  expect(address2).to be_valid
end
```

*app/models/address.rb*
```ruby
class Address < ApplicationRecord
  belongs_to :account
  validates :street_number, :street_name, :city, :state, :zip, presence: true
  validates :street_number, :street_name, :city, :state, :zip, uniqueness: { scope: :account, message: 'account data must be unique' }
end
```

- As a developer, I want to validate that the Address street_number and zip are numbers. Hint: Read about Numericality in the Rails validation docs.

*spec/models/address_spec.rb*
```ruby
it 'street number must be a number' do
  address = Address.create street_number: 'Number', street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: account.id
  expect(address.errors[:street_number].first).to eq 'is not a number'
end
it 'zip must be a number' do
  address = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 'Zip', account_id: account.id
  p address
  expect(address.errors[:zip].first).to eq 'is not a number'
end
```

*app/models/address.rb*
```ruby
class Address < ApplicationRecord
  belongs_to :account
  validates :street_number, :street_name, :city, :state, :zip, presence: true
  validates :street_number, :street_name, :city, :state, :zip, uniqueness: { scope: :account, message: 'account data must be unique' }
  validates :street_number, :zip, numericality: true
end
```

- As a developer, I want to see a custom error message that says "Please, input numbers only" if street_number or zip code are not numbers. Hint: Read about message in the Rails validation docs.

*spec/models/address_spec.rb*
```ruby
it 'street number must be a number' do
  address = Address.create street_number: 'Street Number', street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 92603, account_id: account.id
  expect(address.errors[:street_number].first).to eq 'Please, input numbers only'
end
it 'zip must be a number' do
  address = Address.create street_number: 1234, street_name: 'Sudden Valley Way', city: 'Newport Beach', state: 'CA', zip: 'Zip', account_id: account.id
  p address
  expect(address.errors[:zip].first).to eq 'Please, input numbers only'
end
```

*app/models/address.rb*
```ruby
class Address < ApplicationRecord
  belongs_to :account
  validates :street_number, :street_name, :city, :state, :zip, presence: true
  validates :street_number, :street_name, :city, :state, :zip, uniqueness: { scope: :account, message: 'account data must be unique' }
  validates :street_number, :zip, numericality: { message: 'Please, input numbers only' }
end
```
