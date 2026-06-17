class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_one_attached :image
  def get_profile_image(width, height)
    if image.attached?
      image.variant(resize_to_fill: [width, height]).processed
    else
      "no_image_square.jpg"
    end
  end
  validates :name, presence: true
  validates :handle_name, presence: true
  validates :email_address, presence: true

end
