class BlogPostsController < ApplicationController
  def index
    @posts = BlogPost.all
    # render "index.html.erb"
    # this is commented out because rails magic doesn't need us to explicitly note this, but it is happening behind the scenes
  end

  def show
    @post = BlogPost.find(params[:id])
    # render "show.html.erb"
  end

  def new
  end

  def create
    @post = BlogPost.create(
      title: params[:title],
      content: params[:content]
    )

    if @post.valid?
      redirect_to @post
    else
      render action: :new
    end
  end

  def delete
    @post = BlogPost.find(params[:id])
    if @post.destroy
      redirect_to blog_posts_path
    else
      redirect_to blog_post_path(@post)
    end
  end

end
