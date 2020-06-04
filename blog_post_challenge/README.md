# Blog Post Challenge

### Story: As a developer, I can create a blog application.
- Create a new rails app
```
rails new blog_post_challenge -d postgresql -T
cd blog_post_challenge
rails db:create
rails server
```
In a browser navigate to: `http://localhost:3000` or `127.0.0.1:3000` to view the Rails application

### Story: As a developer, my blog post can have a title and content.
- create the model `rails g model BlogPost title:string content:text publish_date:date`
- `rails db:migrate`
- `rails c`

### Story: As a developer, I can add new blog posts to my database.
- add new instances of blog posts
- `BlogPost.create title: 'Hey Everyone', content: 'Learning about Rails is fun!', publish_date: Date.today.to_s`
- `BlogPost.create title: 'Rails Forms', content: 'Today we will learn how to put a form in a rails app', publish_date: Date.today.to_s`

### Story: As a developer, my blog application can have many comments for each post. The comment has an author and content.
- create the model `rails g model Comments author_name:string content:string blog_post_id:integer`
- `rails db:migrate`
- add `has_many :comments` to the model class BlogPost
- add `belongs_to :blog_post` to the model class Comments

### Story: As a developer, I can add new comments to the blog posts in my database.
- add new instances of comments to a post
- `rails c`
- create a variable to identify one of the posts `post = BlogPost.first`
- `post.comments.create author_name: 'Sarah', content: 'Rails is great!'`
- no need to give a value for the blog_post_id since it is being creating as part of the post variable that contains the first blog entry

## Changing the Shape of the Database (not in challenge)
- After the model has been created a migration can add additional columns to the table
- `rails g migration add_approved_to_comments`
- a new migration will be created with a method called def change
- add a column to the comments table that is called is_approved, is a boolean and starts with a default value of false
- `add_column :comments, :is_approved, :boolean, default: false`
- `rails db:migrate`


### Story: As a user, I can see all the blog titles listed on the home page of the application.
**Creating the View - Index (Show All)**
- `rails g controller BlogPosts`
- create a controller method that will display all the blog posts called index
- `@posts = BlogPost.all`
- create a view file in app/view/blog_post called `index.html.erb`
- use erb to iterate over the blog posts and display them as a list
```html
<h1>Blog Posts</h1>

<ul>
  <% @posts.each do |post| %>
    <li>
      <%= post.title %>
    </li>
  <% end %>
</ul>
```
- add a route `get "blog_posts" -> "blog_posts#index"`
- can add `root to: 'blog_posts#index'` to avoid the boilerplate rails page
- now `localhost:3000` will show us a list of blog post titles

### Story: As a user, I can click on the title of a blog and be routed to a page where I see the title and content of the blog post I selected.
**Creating the View - Show (Show One)**
- create a controller method that will display all the blog posts called show
- `@post = BlogPost.find(params[:id])`
- add a route `get "blog_posts/:id" => "blog_posts#show"`
- create a view file in app/view/blog_post called `show.html.erb`
```html
<h1><%= @post.title %></h1>
<p><%= @post.content %></p>

<ul>
  <% @post.comments.each do |comment| %>
    <li>
      <%= comment.content %>, by: <%= comment.author_name %>
    </li>
  <% end %>
</ul>
```
- now `localhost:3000/blog_posts/1` will show one blog post with the comments

**Linking Between Pages**
- add a helper to the route `as: "all_posts"` and `as: "blog_post"`
- `link_to` takes two arguments, the first one is an anchor tag and the second is the path or href
- update the `<li>` in index.html.erb `<%= link_to post.title, blog_post_path(post) %>`
- the blog_post_path does so ruby magic to the `as: "blog_post"` in the routes and takes the argument of the placeholder post from `.each do` to get the id of the post
- now each blog post title is a hyperlink

### Story: As a user, I can navigate back to the home page.
- to get back to the list of posts add `<%= link_to "All Posts", all_posts_path %>`
- all_posts_path doesn't take an argument here because the route doesn't need a param

### Story: As a user, I can click a button that will take me to a page where I can create a blog post.
- add a `show` and a `new` method to the controller
- add a route `get "blog_posts/new" => "blog_posts#new", as: "new_blog_post"`
- routes are very specific and must be in a particular order so this route must be above the show route
- add a post route for the create method at the end of the list of routes `post "blog_posts" => "blog_posts#create"`
- create a view file in app/view/blog_post called `new.html.erb`
- add html tags for a form, labels and inputs
``` html
<%= form_with url: "/blog_posts", local: true do %>
  <label for="title">Title</label>
  <input type="text" name="title">
  <br>
  <label for="content">Content</label>
  <textarea name="content"></textarea>
  <br>
  <input type="submit" name="" value="submit">
<% end %>
```
- form needs to be wrapped in some ruby syntax to bypass the authenticity token rails wants before submitting new information
- add a link to go to the new blog_post page `<%= link_to "New Post", new_blog_post_path%>`

### Story: As a user, I can click a button that will submit my blog post to the application.
- Add a info to the controller method `@post = BlogPost.create(title: params[:title], content: params[:content])`
- Now add info to the create method in the controller
```ruby
  if @post.valid?
    redirect_to @post
  else
    render action: :new
  end
```

### Story: As a user, I can see my blog title listed on the home page.
- If the post is valid we will redirect to the page showing the post information, if it doesn't work it will route back to the create a post page

### Story: As a user, I can delete my blog post
- add a route `delete "blog_post/:id" => "blog_posts#delete", as: "delete_blog_post"`
- add a delete method to the controller
```ruby
  @post = BlogPost.find(params[:id])
  if @post.destroy
    redirect_to blog_posts_path
  else
    redirect_to blog_post_path(@post)
  end
```
- Add a link to the view `<%= link_to "Delete", delete_blog_post_path(@post), method: :delete %>`

### Story: As a user, I can update my blog post.



def update
  @student = Student.find(params[:id])
  @student.update(student_params)
  if @student.valid?
    render json: @student
  else
    render json: @student.errors
  end
end
