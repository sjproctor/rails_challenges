# Intro to Active Record

Create, Update, Insert, Delete with Active Record in the Rails console.

### Setup
- Create a new Rails app named 'rolodex'.  
`$ rails new rolodex -d postgresql -T`
`$ cd rolodex`

- Create the database, the outcome should look like this:
```
Created database 'rolodex_development'
Created database 'rolodex_test'
```
`$ rails db:create`

- Generate a Person model with a first_name, last_name, and phone. All fields should be strings.  
`$ rails generate model Person first_name:string last_name:string phone:string`

- Run a migration to set up the database.  
`$ rails db:migrate`

- Open up Rails console.  
`$ rails c`

### Challenges
- Add five family members into the Person table in the Rails console.
```
> Person.create last_name: "Proctor", first_name: "Kayti", phone: "555-1234"
> Person.create last_name: "Proctor", first_name: "Becky", phone: "555-2345"
> Person.create last_name: "Engstrom", first_name: "Erik", phone: "555-3456"
> Person.create last_name: "Engstrom", first_name: "JP", phone: "555-4567"
> Person.create last_name: "Staninslaw", first_name: "Rachael", phone: "555-5678"
```

- Retrieve all the items in the database.  
`> Person.all`

- Add yourself to the Person table.  
`> Person.create last_name: "Proctor", first_name: "Sarah", phone: "555-0000"`

- Retrieve all the entries that have the same last_name as you.  
`> Person.where last_name:"Proctor"`

- Update the phone number of the last entry in the database.  
```
> rachael = Person.last
> rachael.phone = "555-9999"
> rachael.save
```

- Retrieve the first_name of the third Person in the database.  
`Person.find(3)`

### Stretch Challenges
- Update all the family members with the same last_name as you, to have the same phone number as you.  
`Person.where(last_name: 'Proctor').map{|person| person.update(phone: '555-0000')}`

- Remove all family members that do not have your last_name.  
`Person.where.not(last_name: 'Proctor').destroy_all`
