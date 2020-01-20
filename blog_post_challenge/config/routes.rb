Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # routes for blog post
  # rails looks for the routes from the top down

  # index route will show all posts
  get "blog_posts" => "blog_posts#index", as: "all_posts"

  # new route will allow our user to create a new blog post
  get "blog_posts/new" => "blog_posts#new", as: "new_blog_post"

  # show route takes the parameter of an id and shows one post
  get "blog_posts/:id" => "blog_posts#show", as: "blog_post"

  # post method that will create a new blog post, doesn't need an 'as'
  post "blog_posts" => "blog_posts#create"

  # the delete route looks similar to the show route since one post must be identified to be deleted
  delete "blog_post/:id" => "blog_posts#delete"

  # page displayed instead of the boilerplate rails page
  root to: 'blog_posts#index'
end
