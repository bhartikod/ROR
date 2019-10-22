class CommentsController < ApplicationController
	def index
      @post = Post.find(params[:post_id])
    #@post = Post.find_by_id(params[:id])
    #if @post.present?
      @comments = @post.comments
    #else
     # redirect_back fallback_location: root_path
    #end
  end
def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
   end
  def create
   @post = Post.find(params[:post_id])
    if @post.present?
      #@comment = current_user.comments.new(comment_params)
      @comment = @post.comments.create(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
      
        flash[:notice] = "comment was successfully created."
      
      redirect_to post_comments_path
      
    else
    
      redirect_back fallback_location: root_path
    end
    end
  end
    #@post = Post.find_by_id(params[:comment][:post_id])
  #  @post = Post.find(params[:post_id])
  #   @post = current_user.posts.new(post_para
  #      @comment = @post.comments.create(comment_params)
  #     if @comment.save
  #       redirect_to post_comments_path
  #     else
  #      redirect_to new_post_comment_path
  #     end
  # end

def edit
  #@post = Post.find(params[:post_id])
  @comment = Comment.find(params[:id])
  #@post = Post.find(params[:post_id])
  #unless @comment.user == current_user
  #redirect_to root_path, notice: 'You are not authorised to access that page!'
#end
end

def update
@comment = Comment.find(params[:id])

if @comment.update(comment_params)
redirect_to post_comments_path(post_id: @comment.post.id), notice: "Updated successfully"
else
flash[:error]= @comment.errors&.full_messages
redirect_to edit_comment_path(@comment) 
end
end


def destroy
@comment = Comment.find(params[:id])
@comment.destroy
redirect_to post_comments_path(id: @comment.id,post_id: @comment.post_id), notice: "Destroyed successfully"
end 

def like
@comment = Comment.find(params[:id])
if @comment.likes.find_by_user_id(current_user.id).present?
@comment.likes.find_by_user_id(current_user.id)&.destroy
else
@comment.likes.create(user_id: current_user.id)
end
redirect_to post_comments_path(id: @comment.id,post_id: @comment.post_id)
end

private

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
#   def new
# 		@post = Post.find(params[:post_id])
# 		@comment = @post.comments.new
# 	end
# 	def create
#     	@post = Post.find(params[:post_id])
#     	@comment = @post.comments.create(comment_params)
#     	redirect_to new_post_comment_path
#   	end
#  	def edit
#  		@post = Post.find(params[:post_id])
#  		@comment = @post.comments.find(params[:id])
#  	end
#  	def update
#  		@post = Post.find(params[:post_id])
#  		@comment = @post.comments.find(params[:id])
#  		if @comment.update(post_params)
#     		redirect_to new_post_comment_path
#   		else
#     		render 'edit'
#   		end
#  	end
#  	def destroy
#  		@post = Post.find(params[:post_id])
 		
#  		@comment = @post.comments.find(params[:id])
#  		@comment.destroy
 
#   		 redirect_to new_post_comment_path
#  	end
#   def like
#       @comment = Comment.find(params[:id])
#       if @comment.likes.find_by_user_id(current_user.id).present?
#           @comment.likes.find_by_user_id(current_user.id)&.destroy
#       else
#           @comment.likes.create(user_id: current_user.id)
#       end
#         redirect_to posts_path
#     end
#   private
#     def comment_params
#       params.require(:comment).permit(:content)
#     end
# end
