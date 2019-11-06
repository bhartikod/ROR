class PostsController < ApplicationController
	#before_action :set_post, only: [:edit, :update, :show]
	before_action :find_post, only:[:show, :edit,:update, :destroy]
	def index
		@posts = Post.all.order("created_at DESC")
		@post = current_user.posts.new
	end
	
	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.new(post_params)
		@post.save
    		
	end
	
	def edit
		respond_to do |format|
			format.html
			format.js
		end
	end
	
	def like
    	@post = Post.find(params[:id])
    	if @post.likes.find_by_user_id(current_user.id).present?
        	@post.likes.find_by_user_id(current_user.id)&.destroy
    	else
      		@post.likes.create(user_id: current_user.id)
    	end
  	end
	
	def update
		@post.update(post_params)
	end

	def show
		@comments = Comment.where(post_id: @post)
		@profile = current_user.profile
	end
	
	def destroy
	  @post.destroy
  end

	private

	def find_post
		@post = Post.find(params[:id])
	end
	
	def post_params
		 params.require(:post).permit(:title, :description)
	end


end
