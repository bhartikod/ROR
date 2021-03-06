class ProfilesController < ApplicationController
	before_action :set_profile, only: [:edit, :update]
	def new
		@profile = Profile.new
	end
	
	def create
		#@profile = Profile.new(profile_params)
		@profile = current_user.build_profile(profile_params)
		#@profile.user_id = current_user.id
		if @profile.save
			
    		redirect_to posts_path
  		else
    		render 'new'
  		end
	end
	
	def edit
	end
	
	def update
		
		if @profile.update(profile_params)
    		redirect_to @profile
  		else
    		render 'edit'
  		end
	end
	def show
		@profile = Profile.find(params[:id])
	end

	private
	def set_profile
  		@profile = current_user.profile
	end
	def profile_params
		params.require(:profile).permit(:fname, :lname, :address)
	end
end
