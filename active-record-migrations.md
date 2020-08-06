# Active Record Migrations

### Setup
- Create a new rails application called 'favorite_movies'  
`$ rails new rolodex -d postgresql -T`
`$ cd rolodex`

- Create the database  
`$ rails db:create`

- Generate a Movie model with a title attribute and a category attribute  
`$ rails generate model Movie title:string category:string`

### Challenges
- Add five entries to the database in Rails console
```
> Movie.create title: "Little Mermaid", category: "Mysteries of the Sea"
> Movie.create title: "Aladdin", category: "Defying Physics"
> Movie.create title: "Beauty and the Beast", category: "Stockholm Syndrome"
> Movie.create title: "Mulan", category: "Nobody puts baby in a corner"
> Movie.create title: "Lion King", category: "Hamlet, revisited"
```

- Create a migration to add a new column to the database called movie_length  
`$ rails generate migration add_movie_length`
```ruby
class AddMovieLength < ActiveRecord::Migration[6.0]
  def change
    add_column :movie, :movie_length, :string
  end
end
```
`$ rails db:migrate`

- Update the values of the existing attributes to include a movie_length value
```
> lm = Movie.find(1)
> lm.movie_length = "1h 25m"
> lm.save
>
> al = Movie.find(2)
> al.movie_length = "2h 8m"
> al.save
>
> bb = Movie.find(3)
> bb.movie_length = "2h 19m"
> bb.save
>
> mu = Movie.find(4)
> mu.movie_length = "1h 28m"
> mu.save
>
> lk = Movie.find(5)
> lk.movie_length = "1h 58m"
> lk.save
```

- Generate a migration to rename the column 'category' to 'genre'  
`$ rails generate migration update_category_name`
```ruby
class UpdateCategoryName < ActiveRecord::Migration[6.0]
  def change
    rename_column :movie, :category, :genre
  end
end
```
`$ rails db:migrate`
