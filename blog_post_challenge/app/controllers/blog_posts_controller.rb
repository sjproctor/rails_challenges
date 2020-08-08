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

  def edit
    @post = BlogPost.find(params[:id])
  end

  # without strong params
  def create
    @post = BlogPost.create(
      title: params[:title],
      content: params[:content],
      publish_date: params[:publish_date]
    )
    if @post.valid?
      redirect_to blog_post_path(@post)
    else
      render action: :new
    end
  end

  # with strong params
  # def create
  #   @post = BlogPost.create(blog_post_params)
  #   if @post.valid?
  #     redirect_to blog_post_path
  #   else
  #     render action: :new
  #   end
  # end

  def destroy
    @post = BlogPost.find(params[:id])
    if @post.destroy
      redirect_to blog_posts_path
    else
      redirect_to blog_post_path(@post)
    end
  end

  # without strong params
  def update
    @post = BlogPost.find(params[:id])
    @post.update(
      title: params[:title],
      content: params[:content],
      publish_date: params[:publish_date]
    )
    if @post.valid?
      redirect_to blog_post_path
    else
      redirect_to blog_post_path(@post)
    end
  end

  # with strong params
  # def update
  #   @post = BlogPost.find(params[:id])
  #   @post.update(blog_post_params)
  #   if @post.valid?
  #     redirect_to blog_post_path
  #   else
  #     redirect_to blog_post_path(@post)
  #   end
  # end

  # private
  # def blog_post_params
  #   params.permit(:title, :content, :publish_date)
  # end

end
