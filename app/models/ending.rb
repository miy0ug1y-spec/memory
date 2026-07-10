class Ending < ApplicationRecord
  belongs_to :user
 
  has_many :ending_posts, dependent: :destroy
  has_many :posts ,through: :ending_posts

  has_one_attached :image

end
