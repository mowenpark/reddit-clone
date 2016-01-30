class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update]

  def show
    @post = Post.find_by_id(params[:id])
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find_by_id(params[:id])
    render :edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to sub_post_url(@post.sub, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(post_params)
      redirect_to sub_post_url(@post.sub, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.destroy
      redirect_to sub_url(Sub.find_by_id(@post.sub_id))
    else
      flash.now[:errors] = @post.errors.full_messages
      render :show
    end
  end

  private

  def is_author?
    current_user.id == Post.find_by_id(params[:id]).author_id
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :author_id)
  end
end
