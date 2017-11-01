class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.sub_id)
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.author_id == current_user.id
      if @post.update_attributes(post_params)
        redirect_to sub_url(@post.sub_id)
      else
        flash.now[:errors] = @post.errors.full_messages
        render :edit
      end
    else
      flash[:errors] = ["you are not the post author"]
      redirect_to sub_url(@post.sub_id)
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end

end
