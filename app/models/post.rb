class Post < ApplicationRecord
	has_many :comments , dependent: :destroy
	has_many :likes, :as => :likeable , dependent: :destroy
	belongs_to :user
	validates_length_of :title, :maximum => 10
end
