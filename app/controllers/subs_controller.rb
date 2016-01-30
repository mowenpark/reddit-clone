class SubsController < ApplicationController
  before_action :check_mod?, only: [:edit, :update]

  def index
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    render :show
  end

  private

  def check_mod?
    current_user.id == Sub.find_by(id: params[:id])
  end

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
end
