class ApplicationController < ActionController::Base
	layout :set_layout

	def set_layout
		if devise_controller?
			"devise"
		else
			"application"
		end
	end

	def after_sign_in_path_for(resource)		
		if resource.profile.present?
 			posts_path
		else
 			new_profile_path 
		end
	end
end
