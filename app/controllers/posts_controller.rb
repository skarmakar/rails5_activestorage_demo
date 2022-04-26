class PostsController < ApplicationController
  def index
    render json: Post.all
  end

  def create
    post = Post.create(post_params)
    render json: post
  end

  private

  def post_params
    params.require(:post).permit(:title, :photo)
  end
end
