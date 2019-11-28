class Users::OmniauthCallbacksController < ApplicationController
	 def facebook
        @user = UserProvider.find_for_facebook_oauth(request.env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication               
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
    end

    def google_oauth2
        @user = UserProvider.find_for_google_oauth(request.env["omniauth.auth"])
        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication
        else
          session["devise.user_attributes"] = user.attributes
          redirect_to new_user_registration_url
        end
    end

	# def facebook
	  
	#   @user = User.create_from_provider_data(request.env['omniauth.auth'])
	#   if @user.persisted?
	#     sign_in_and_redirect @user
	#     #set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
	#   else
	#     flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
	#     redirect_to new_user_registration_url
	#   end 
	# end

	# def google_oauth2

	#   @user = User.create_from_google_data(request.env['omniauth.auth'])
	
	#   if @user.persisted?
	#     sign_in_and_redirect @user
	#    # set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
	#   else
	#     flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
	#     redirect_to new_user_registration_url
	#   end 
	# end

	# def failure
 #  		flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
 #  		redirect_to new_user_registration_url
 #  	end
end
