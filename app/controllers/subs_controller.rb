class SubsController < ApplicationController

  before_action :require_log_in

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.moderator_id == current_user.id
      if @sub.update_attributes(sub_params)
        redirect_to sub_url(@sub.id)
      else
        flash.now[:errors] = @sub.errors.full_messages
        render :edit
      end
    else
      flash.now[:errors] = ["You are not a moderator"]
      redirect_to sub_url(@sub.id)
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
