class CommentsController < ApplicationController
	
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end
  
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end
  
  def create
    @post = Post.find(params[:post_id])
    if @post.present?
      @comment = @post.comments.create(comment_params)
      @comment.user_id = current_user.id
      @comment.save
    end
  end

  def edit
   @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    #@post = Post.find_by(id: @comment.post_id)
    @comment.destroy
  end 

  def like
    @comment = Comment.find(params[:id])
    if @comment.likes.find_by_user_id(current_user.id).present?
      @comment.likes.find_by_user_id(current_user.id)&.destroy
    else
       @comment.likes.create(user_id: current_user.id)
    end
     # redirect_to post_comments_path(id: @comment.id,post_id: @comment.post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
