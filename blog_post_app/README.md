# Blog Post Challenge
As a developer, I have been commissioned to create an application where a user can see and create blog posts.

#### As a developer, I can create a blog application. (done)
- Create a new rails app and create a database
```
$ rails new blog_post_app -d postgresql -T
$ cd blog_post_app
$ rails db:create
$ rails server
```



#### As a developer, my blog post can have a title and content. (done)
```
$ rails generate model BlogPost title:string content:string
$ rails db:migrate
```



#### As a developer, I can add new blog posts to my database. (done)
- `$ rails c`
- Add some content to the database:
  - `BlogPost.create title: "Mary Kenneth Keller", content:
"Mary Kenneth Keller was one of the first people in the US to earn
 PhD in computer science and the first woman to do so."`
  - `BlogPost.create title: "Ada Lovelace", content: "Ada L
velace is regarded as the first person to recognise the full potent
al of computers and one of the first computer programmers."`
  - `BlogPost.create title: "Grace Hopper", content: "Grace
Hopper was one of the first programmers of the Harvard Mark compute
 and a pioneer of computer programming who popularized the idea of
achine-independent proramming languages."`



#### As a user, I can see all the blog titles listed on the home page of the application. (done)
- Add a controller: `$ rails generate controller blog_posts`
  - This creates the controller and the view folder
  - Remove stylesheets: `$ rm app/assets/stylesheets/blog_posts.scss`
  - Remove the helpers: `$ rm app/helpers/blog_posts_helper.rb`

**Controller**
- Create a controller method that will display all the blog posts called `index`

```ruby
  def index
    @posts = BlogPost.all
  end
```

**View**
- Create a view file in *app/view/blog_posts* called `index.html.erb`
- Use `erb` to iterate over the blog posts and display them as a list

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

**Routes**
- Add a route `get 'blog_posts' => 'blog_posts#index'`
- (Optional) Can add `root to: 'blog_posts#index'` to avoid the boilerplate rails page
- Now `localhost:3000` or `localhost:3000/blog_posts` will show us a list of blog post titles



#### As a user, I can click on the title of a blog and be routed to a page where I see the title and content of the blog post I selected. (done)
**Controller**
- Create a controller method that will display all the blog posts called `show`

```ruby
  def show
    @post = BlogPost.find(params[:id])
  end
```

**View**
- Create a view file in *app/view/blog_posts* called `show.html.erb`

```html
  <h1><%= @post.title %></h1>
  <p><%= @post.content %></p>
```
**Routes**
- Add a route `get 'blog_posts/:id' => 'blog_posts#show'`
- Now `localhost:3000/blog_posts/1` will show one post with the title and content

**Linking Between Pages**
- Add an alias to the show route `get 'blog_posts/:id' => 'blog_posts#show', as: 'post'`
- Turn each blog post title in the *index.html.erb* file into link
- The `link_to` takes two arguments, the first one is an anchor tag and the second is the path or href
- By appending `_path` to the end of the route alias becomes an href

```html
  <li>
    <%= link_to post.title, post_path(post) %>
  </li>
```



#### As a user, I can navigate from the show page back to the home page. (done)
- Add an alias to the index route `get 'blog_posts' => 'blog_posts#index', as: 'posts'`
- To get back to the list of posts add `<%= link_to "Back to All Posts", posts_path %>`



#### As a user, I see a form where I can create a new blog post. (done)
**Controller**
- Create a controller method called `new` that will render a form for the user

```ruby
  def new
  end
```

**View**
- Create a view file in *app/view/blog_posts* called `new.html.erb`
- Add erb tags with a Ruby helper method for a form, labels and inputs

```html
  <h3>Add a New Blog Post</h3>
  <%= form_with url: '/blog_posts', local: true do |form| %>

    <%= form.label :title %>
    <%= form.text_field :title %>

    <br />
    <%= form.label :content %>
    <%= form.text_field :content %>

  <% end %>
```

**Routes**
- Add a route `get 'blog_posts/new' => 'blog_posts#new'`
- Now `localhost:3000/blog_posts/new` will show a form to create a new blog post
- Routes are very specific and must be in a particular order so this route must be above the show route



#### As a user, I can click a button that will take me from the home page to a page where I can create a blog post. (done)
- Add an alias to the new route `get 'blog_posts/new' => 'blog_posts#new', as: 'new_posts'`
- To get to the form from *index.html.erb* add `<%= link_to "Add a New Post", new_post_path %>`



#### As a user, I can navigate from the form back to the home page.
- To get to back to the home page from *new.html.erb* add `<%= link_to "Back to All Posts", posts_path %>`



#### As a user, I can click a button that will submit my blog post to the database. (done)
**Controller**
- Create a controller method called `create` that will submit the data from the form to the database

```ruby
  def create
    @post = BlogPost.create(
      title: params[:title],
      content: params[:content]
    )
  end
```
**View**
- Add a submit button and clear button to the form in *new.html.erb*

```html
  <%= form.submit 'Add Blog Post' %>
  <%= form.submit 'clear', :type => 'reset' %>
```

**Routes**
- Add a route `post 'blog_posts' => 'blog_posts#create'`



#### As a user, I when I submit my post, I am redirected to the home page. (done)
**Controller**
- Update the `create` method to redirect after the data is submitted to the database

```ruby
  def create
    @post = BlogPost.create(
      title: params[:title],
      content: params[:content]
    )
    if @post.valid?
      redirect_to posts_path
    else
      redirect_to new_post_path
    end
  end
```



## Stretch Challenges
#### As a user, I can delete my blog post. (done)
**Controller**
- Create a controller method called `destroy` to remove an unwanted blog post from the database

```ruby
  def destroy
    @post = BlogPost.find(params[:id])
    if @post.destroy
      redirect_to posts_path
    else
      redirect_to post_path(@post)
    end
  end
```

**View**
- Add a link on the show page that will call the destroy route

```html
<br />
<%= link_to 'Delete Blog Post', delete_post_path(@post), method: :delete, data: { confirm: 'Are you sure?' } %>
```

**Routes**
- Add a route `delete 'blog_posts/:id' => 'blog_posts#destroy', as: 'delete_post'`




#### As a user, I can update my blog post. (done)
**Controller**
- Create a controller method called `edit` that will display an update form for the user
- Create a controller method called `update` that will update an existing item in the database

```ruby
  def edit
  end

  def update
    @post = BlogPost.find(params[:id])
    @post.update(      
      title: params[:title],
      content: params[:content]
    )
    if @post.valid?
      redirect_to post_path(@post)
    else
      redirect_to edit_post_path
    end
  end
```

**View**
- Create a view file in *app/view/blog_posts* called `edit.html.erb`
- Add erb tags with a Ruby helper method for a form, labels and inputs

```html
  <h3>Edit Blog Post</h3>
  <%= form_with url: "/blog_posts/#{params[:id]}", method: :patch, local: true do |form| %>

    <%= form.label :title %>
    <%= form.text_field :title %>

    <br />
    <%= form.label :content %>
    <%= form.text_field :content %>

    <br />
    <%= form.submit 'Edit Blog Post' %>
    <%= form.submit 'Clear Form', :type => 'reset' %>
  <% end %>
```


- Link from *show.html.erb* to the edit form

```html
  <%= link_to 'Edit Blog Post', edit_post_path(@post) %>
```

**Routes**
- Add a route `get 'blog_posts/:id/edit' => 'blog_posts#edit', as: 'edit_post'`
- Add a route `patch 'blog_posts/:id' => 'blog_posts#update'`
