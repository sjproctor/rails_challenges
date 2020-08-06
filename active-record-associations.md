# Active Record Associations: Banking Challenge

### Setup
- Create a new rails application and database
```
$ rails new banking_challenge -d postgresql -T
$ cd banking_challenge
$ rails db:create
```

- Create a model for owner
- An owner has a name and address, and can have multiple credit cards
```
$ rails g model Owner name:string address:string
```

- Create a model for credit card
A credit card has a number, an expiration date, and an owner
```
$ rails g model CreditCard number:integer exp_date:string owner_id:integer
$ rails db:migrate
```
**app/model/credit_card.rb**
```ruby
class CreditCard < ApplicationRecord
  belongs_to :owner
end
```

**app/model/owner.rb**
```ruby
class Owner < ApplicationRecord
  has_many :credit_cards
end
```

### Challenges
- Create three owners and save them in the database
```
> Owner.create name: "Bugs Bunny", address: "123 Toon L
ne"
> Owner.create name: "Foghon Leghorn", address: "345 Fa
m Place"
> Owner.create name: "Marvin the Martian", address: "Ol
mpus Mons, Mars"
```

- Create a credit card in the database for each owner
```
> bb = Owner.first
> bb.credit_cards.create number: 12345678, exp_date: "03
/99"
> fl = Owner.find 2
fl.credit_cards.create number: 78912345, exp_date: "12
/88"
> mm = Owner.find 3
mm.credit_cards.create number: 45678901, exp_date: "06
/78"
```

- Add two more credit cards to one of the owners
```
> bb.credit_cards.create number: 34561234, exp_date: "09
/44"
> bb.credit_cards.create number: 34567890, exp_date: "03
/66"
```

### Stretch Challenge
- Add a credit limit to each card
```
$ rails g migration adds_limit_to_card
```

```ruby
class AddsLimitToCard < ActiveRecord::Migration[6.0]
  def change
    add_column :credit_cards, :credit_limit, :integer
  end
end
```
```
> bb = CreditCard.first
> bb.credit_limit = 5000
> bb.save
>
> fl = CreditCard.find 2
> fl.credit_limit = 10000
> fl.save
>
> bb = CreditCard.find 4
> bb.credit_limit = 25000
> bb.save
>
> bb = CreditCard.find 5
> bb.credit_limit = 10000
> bb.save
```

- Find the total credit extended to the owner with multiple credit cards
```
bb.credit_cards.map { |value| value.credit_limit }.sum
```
