Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # routes for blog post
  # rails looks for the routes from the top down

  # index route will show all posts
  get "blog_posts" => "blog_posts#index", as: "all_posts"

  # new route will show a form that will allow the user to add information, works in conjunction with 'new'
  get "blog_posts/new" => "blog_posts#new", as: "new_blog_post"

  # post method will take the infomation in the form and add it to the database, doesn't need an 'as'
  post "blog_posts" => "blog_posts#create"

  # show route takes the parameter of an id and shows one post
  get "blog_posts/:id" => "blog_posts#show", as: "blog_post"

  # edit route will show the user a form so an existing entry can be modified
  get 'blog_posts/edit/:id' => 'blog_posts#edit', as: 'edit_blog_post'

  # the update route will allow an exisiting entry to be edited, takes the argument of the id of the post
  patch 'blog_posts/:id' => 'blog_posts#update'

  # the delete route looks similar to the show route since one post must be identified to be deleted
  delete "blog_post/:id" => "blog_posts#destroy"

  # page displayed instead of the boilerplate rails page
  root to: 'blog_posts#index'
end
