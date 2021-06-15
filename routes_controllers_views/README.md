# Routes, Controllers, and Views Challenges
Updated: June 2021

- Create a Rails application called our_favorites. The app will have a PostgreSQL database.
- Generate a controller called Main.
- Generate additional controllers named for EACH member of the team, e.g. ` $ rails generate controller George`
  ```
  $ rails g controller Main
  $ rails g controller Sarah
  $ rails g controller Austin
  ```
  - remove unnecessary files

**User Stories**
- As a user, I can see a landing page at 'localhost:3000' that has a title of the application and subtitles with each team member's name.
  - HINT: Use the main controller to create the landing page.
    - Create a controller method
    ```ruby
    class MainController < ApplicationController
      def landing
      end
    end
    ```
    - Create a view file in the main folder called `landing.html.erb`
    ```html
    <h1>Top Three</h1>
    <h2>Sarah</h2>
    <h2>Austin</h2>
    ```
    - Create a route to the landing page
    - Add a root helper method to the the landing page
    ```ruby
    Rails.application.routes.draw do
      root 'main#landing'
      get '/landing' => 'main#landing'
    end
    ```
- As a user, I can see a list of each team member's top three things. (Could be top three restaurants, activities, books, video games, hiking locations, beaches, doughnut shoppes, movies, etc.)
  - Add list items
  ```html
  <h1>Top Three</h1>
  <h2>Sarah's Favorite Books</h2>
  <ul>
    <li>A Short History of Nearly Everything</li>
    <li>Me Talk Pretty One Day</li>
    <li>The Adventures of Sherlock Holmes</li>
  </ul>
  <h2>Austin's Favorite Cars</h2>
  <ul>
    <li>Porsche Taycan</li>
    <li>McLaren Senna</li>
    <li>Ferrari Testarossa</li>
  </ul>
  ```
- As a user, I can see that each of the list items are links.
  - Add ERB tags and link_to to every item
  - Wrap the item in a string to create the hyperlink
  ```html
  <h2>Sarah's Favorite Books</h2>
  <ul>
    <li><%= link_to 'A Short History of Nearly Everything' %></li>
    <li><%= link_to 'Me Talk Pretty One Day' %></li>
    <li><%= link_to 'The Adventures of Sherlock Holmes' %></li>
  </ul>
  <h2>Austin's Favorite Cars</h2>
  <ul>
    <li><%= link_to 'Porsche Taycan' %></li>
    <li><%= link_to 'McLaren Senna' %></li>
    <li><%= link_to 'Ferrari Testarossa' %></li>
  </ul>
  ```
- As a user, I can click on a link and be take to a page where I can see more information about that particular list item.
  - HINT: Use the appropriate controller for each teammate. Create methods for each list item. Create view files in the corresponding view folder.
  - Create the controller methods
  ```ruby
  class SarahController < ApplicationController
    def short
    end
    def pretty
    end
    def sherlock
    end
  end
  ```
  ```ruby
  class AustinController < ApplicationController
    def porsche
    end
    def mclaren
    end
    def ferrari
    end
  end
  ```
  - Create the routes
  ```ruby
  Rails.application.routes.draw do
    root 'main#landing'
    get '/landing' => 'main#landing'
    get '/short' => 'sarah#short'
    get '/pretty' => 'sarah#pretty'
    get '/sherlock' => 'sarah#sherlock'
    get '/porsche' => 'austin#porsche'
    get '/mclaren' => 'austin#mclaren'
    get '/ferrari' => 'austin#ferrari'
  end
  ```
  - Create the views in each folder
  ```html
  <h2>Me Talk Pretty One Day</h2>
  <p><%= link_to 'About the book', 'https://en.wikipedia.org/wiki/Me_Talk_Pretty_One_Day' %>
  ```
- As a user, I can return to the landing page from any of the other pages.
  - Add a link to each view
  ```html
  <h2>Me Talk Pretty One Day</h2>
  <p><%= link_to 'About the book', 'https://en.wikipedia.org/wiki/Me_Talk_Pretty_One_Day' %>
  <br />
  <p><%= link_to 'Home', '/' %></p>
  ```
