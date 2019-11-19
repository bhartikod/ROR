class Post < ApplicationRecord
	has_many :comments , dependent: :destroy
	has_many :likes, :as => :likeable , dependent: :destroy
	belongs_to :user
	validates :title, presence: true, length: { maximum: 100 }
end
