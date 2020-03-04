# Rolodex Challenge

- $ rails new rolodex -d postgresql -T
- $ cd rolodex
- $ rails db:create
- $ rails generate model Person first_name:string last_name:string phone:string
- $ rails db:migrate
- $ rails c
- > Person.create last_name: "Proctor", first_name: "Sarah", phone: "555-4455"
- > Person.create last_name: "Proctor", first_name: "Kayti", phone: "555-5588"
- > Person.create last_name: "Proctor", first_name: "Becky", phone: "555-1234"
- > Person.create last_name: "Engstrom", first_name: "Erik", phone: "555-2233"
- > Person.create last_name: "Engstrom", first_name: "JP", phone: "555-2345"
- How many have the same last_name as you?
- > Person.where last_name:"Proctor"
- Update the phone number of the last entry in the database.
- > jp = Person.last
- > jp.phone = "555-7890"
- > jp.save

- Update all the family members with the same last_name as you, to have the same phone number as you.
- `Person.where(last_name: 'Clark').map{|person| person.update(phone: '555-0011')}`
- Remove all family members that do not have your last_name.
- `Person.where.not(last_name: 'Clark').destroy_all`
