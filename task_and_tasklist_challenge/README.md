# Rails Active Record Tasks and Task List Challenge

### Set Up
- $ rails new task_and_tasklist_challenge -d postgresql -D
- $ rails db:create

### Task Challenge

**Story**: As a programmer, I can create a new Task record with a title, which is a string, and description, which is a string.
- $ rails generate model Task title:string description:title
- $ rails db:migrate

**Story**: As a programmer, I can list all Task records.
- $ rails c
- > Task.create title: "Laundry", description: "Wash clothes and towels"
- > Task.create title: "Clean House", description: "Dust and mop floors"
- > Task.create title: "Errands", description: "Wash car and get gas"
- > Task.all

**Story**: As a programmer, I can add a 'done' attribute to my Task.
- $ rails generate migration add_status_to_task
- *db/migrate*
```
class AddStatusToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :string
  end
end
```
- $ rails db:migrate

**Story**: As a programmer, I can set a Task record to 'done' given the ID of the record.
- $ rails db:create
- > clean = Task.find 2
- > clean.status = "done"
- > clean.save
- > laundry = Task.first
- > clean.laundry = "done"
- > laundry.save
- > car.status = "not done"
- > car.save

**Story**: As a programmer, I can list all the records that are done.
- > Task.where status:"done"

**Story**: As a programmer, I can list all the records that are not done.
- > Task.where status:"not done"

**Story**: As a programmer, I can update the title and description of a Task record given the ID of the record.
- > clean.description = "Dust ceiling fan and sweep kitchen"
- > clean.save

**Story**: As a programmer, I can destroy a Task record given the ID of the record.
- > Task.create title: "fjkdsl", description: "flsfjsl"
- > mistake = Task.find 4
- > mistake.destroy
- > Task.all
- The record is gone

**Story**: As a programmer, I can set a Task record with a due date, which is a timestamp.
- $ rails generate migration add_due_date_to_task
**db/migrate**
```
def change
  add_column :tasks, :due_date, :date
end
```
- $ rails db:migrate

**Story**: As a programmer, I can list all the records with a due date.
- $ rails c
- > car = Task.find 3
- > car.due_date = "2020/03/10"
- > car.save
- > car.due_date
- => Tue, 10 Mar 2020

**Story**: As a programmer, I can list all the records with a due date today.
- > laundry = Task.first
- > laundry.due_date = Date.today
- > laundry.save
- > Task.where due_date: Date.today
- => #<ActiveRecord::Relation [#<Task id: 1, title: "Laundry", description: "Wash clothes and towels", created_at: "2020-03-07 01:49:07", updated_at: "2020-03-08 23:25:28", status: "done", due_date: "2020-03-08">]>

**Story**: As a programmer, I can list all the records without a due date.
- > Task.where due_date: nil
- => #<ActiveRecord::Relation [#<Task id: 2, title: "Clean House", description: "Dust ceiling fan and sweep kitchen", created_at: "2020-03-07 01:49:50", updated_at: "2020-03-07 19:41:47", status: "done", due_date: nil>]>

### Tasklist Challenge
**Story**: As a programmer, I can create a Tasklist that has a title and description.
- $ rails generate model Tasklist title:string description:string
- $ rails db:migrate

**Story**: As a programmer, a Tasklists have many Tasks.
- $ rails generate migration add_foreign_key_to_task
**app/models/tasklist.rb**
```
class Tasklist < ApplicationRecord
  has_many :tasks
end
```
**app/models/task.rb**
```
class Task < ApplicationRecord
  belongs_to :tasklist
end
```
**db/migrate**
```
class AddForeignKeyToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :tasklist_id, :integer
  end
end
```
- $ rails db:migrate
- $ rails c
- > car = Task.find 3
- > car
- => #<Task id: 3, title: "Car", description: "Wash car and get gas", created_at: "2020-03-07 01:50:25", updated_at: "2020-03-08 23:56:54", status: "not done", due_date: "2020-03-10", tasklist_id: nil>
- > car.tasklist = Tasklist.first
- > car
- => #<Task id: 3, title: "Car", description: "Wash car and get gas", created_at: "2020-03-07 01:50:25", updated_at: "2020-03-08 23:56:54", status: "not done", due_date: "2020-03-10", tasklist_id: 1>
