class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update]

  def show
    render :show
  end

  def new
    render :new
  end

  def edit
    render :edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to :new
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to :edit
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.destroy
      redirect_to sub_url(Sub.find_by_id(@post.sub_id))
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to :new
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
