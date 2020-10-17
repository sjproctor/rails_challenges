class BlogPostsController < ApplicationController

  def index
    @posts = BlogPost.all
  end

  def show
    @post = BlogPost.find(params[:id])
  end

  def new
    @post = BlogPost.new
  end

  # def create
  #   @post = BlogPost.create(
  #     title: params[:title],
  #     content: params[:content]
  #   )
  #   if @post.valid?
  #     redirect_to posts_path
  #   else
  #     redirect_to new_post_path
  #   end
  # end

  def create
    @post = BlogPost.create(blog_post_params)
    if @post.valid?
      redirect_to posts_path
    else
      redirect_to new_post_path
    end
  end

  def destroy
    @post = BlogPost.find(params[:id])
    if @post.destroy
      redirect_to posts_path
    else
      redirect_to post_path(@post)
    end
  end

  def edit
    @post = BlogPost.find(params[:id])
  end

  # def update
  #   @post = BlogPost.find(params[:id])
  #   @post.update(
  #     title: params[:title],
  #     content: params[:content]
  #   )
  #   if @post.valid?
  #     redirect_to post_path(@post)
  #   else
  #     redirect_to edit_post_path
  #   end
  # end

  def update
    @post = BlogPost.find(params[:id])
    @post.update(blog_post_params)
    if @post.valid?
      redirect_to post_path(@post)
    else
      redirect_to posts_path
    end
  end

  private
  def blog_post_params
    params.require(:blog_post).permit(:title, :content)
  end

end
