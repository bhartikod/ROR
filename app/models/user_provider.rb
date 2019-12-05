class UserProvider < ApplicationRecord
  belongs_to :user
  def self.find_for_provider_data(auth)
    user_provider = UserProvider.where(:provider => auth.provider, :uid => auth.uid).first
    if user_provider.nil?
      registered_user = User.where(:email => auth.info.email).first
      if registered_user.nil?
        user = User.create!(name: auth.info.name,email: auth.info.email,password: Devise.friendly_token[0,20])
        user_provider = UserProvider.create!(provider:auth.provider,uid:auth.uid,user_id: user.id)
        user 
      else
        UserProvider.create!(provider: auth.provider,uid: auth.uid,user_id: registered_user.id)
          registered_user
      end
    else
      user_provider.user    
    end
  end
end
