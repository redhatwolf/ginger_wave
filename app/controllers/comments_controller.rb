class CommentsController < ApplicationController
  #http_basic_authenticate :name=>"tms_auto",:password=>"123",:except=>[:index,:show]
  http_basic_authenticate_with :name => "123", :password => "123", :readonly => :destroy
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    redirect_to post_path(@post)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
  
  def show
    @post = Post.find(params[:id])
  @comment = @post.comments.build
  end

  def new
    @comment = Comment.new
  end

  def edit
     @comment = Comment.find(params[:id])
  @post = Post.find(params[:post_id])
end

 def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    redirect_to @post
  end
end
