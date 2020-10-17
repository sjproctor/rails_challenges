Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'blog_posts' => 'blog_posts#index', as: 'blog_posts'
  get 'blog_posts/new' => 'blog_posts#new', as: 'new_post'
  get 'blog_posts/:id/edit' => 'blog_posts#edit', as: 'edit_post'
  get 'blog_posts/:id' => 'blog_posts#show', as: 'post'
  post 'blog_posts' => 'blog_posts#create'
  patch 'blog_posts/:id' => 'blog_posts#update'
  delete 'blog_posts/:id' => 'blog_posts#destroy', as: 'delete_post'
end
