class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
		
		if resource.profile.present?
   			posts_path
		else
   			new_profile_path 
		end
  	end
end
