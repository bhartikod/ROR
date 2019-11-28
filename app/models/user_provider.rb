class UserProvider < ApplicationRecord
  belongs_to :user
  
  def self.find_for_provider_oauth(auth)
    user_provider = UserProvider.where(:provider => auth.provider, :uid => auth.uid).first

    if user_provider.present?
      user_provider.user
      # "User login and redirect to landing page"
    else
      # New user signup
      # Email: abc@gmail.com
      # FB: abc@gmail.com
      user = User.where(email: auth.info.email).first
      # "fetch email from auth details and if Email ID already exist"
      if user.present?
        user_provider = user.user_providers.new(provider: auth.provider, uid: auth.uid)
        user_provider.save
        user
        # Link FB provider for that user who already exist on our system.
      else
        # "Create New User and it's provider"
        # "User object and 1 provider for that user"
        user = User.create(name: auth.info.name, email: auth.info.email, password: Devise.friendly_token[0,20])
        user_provider = user.user_providers.create(provider:auth.provider, uid:auth.uid)
        user
      end
    end

    # unless user.nil?
    #     user.user
    # else
    #     registered_user = User.where(:email => auth.info.email).first
    #     unless registered_user.nil?
    #                 UserProvider.create!(
    #                       provider: auth.provider,
    #                       uid: auth.uid,
    #                       user_id: registered_user.id
    #                       )
    #         registered_user
    #     else
    #       debugger
    #         user = User.create!(
    #             name: auth.info.name,
    #                     email: auth.info.email,
    #                     password: Devise.friendly_token[0,20],
    #                     )
    #         user_provider = UserProvider.create!(
    #             provider:auth.provider,
    #                     uid:auth.uid,
    #                       user_id: user.id
    #             )
    #         user
    #     end
    # end
  end

  def self.find_for_google_oauth(auth)

    if user_provider.present?
      user_provider.user
      # "User login and redirect to landing page"
    else
      # New user signup
      # Email: abc@gmail.com
      # FB: abc@gmail.com
      user = User.where(email: auth.info.email).first
      # "fetch email from auth details and if Email ID already exist"
      if user.present?
        user_provider = user.user_providers.new(provider: auth.provider, uid: auth.uid)
        user_provider.save
        user
        # Link FB provider for that user who already exist on our system.
      else
        # "Create New User and it's provider"
        # "User object and 1 provider for that user"
        user = User.create(name: auth.info.name, email: auth.info.email, password: Devise.friendly_token[0,20])
        user_provider = user.user_providers.create(provider:auth.provider, uid:auth.uid)
        user
      end
    end

    # user = UserProvider.where(:provider => auth.provider, :uid => auth.uid).first
    # unless user.nil?
    #     user.user
    # else
    #     registered_user = User.where(:email => auth.info.email).first
    #     unless registered_user.nil?
    #                 UserProvider.create!(
    #                       provider: auth.provider,
    #                       uid: auth.uid,
    #                       user_id: registered_user.id
    #                       )
    #         registered_user
    #     else
    #         user = User.create!(
    #             name: auth.info.name,
    #                       email: auth.info.email,
    #                       password: Devise.friendly_token[0,20],
    #                     )
    #         user_provider = UserProvider.create!(
    #             provider:auth.provider,
    #                     uid:auth.uid,
    #                     user_id: user.id
    #             )
    #         user
    #     end
    # end
  end

end
