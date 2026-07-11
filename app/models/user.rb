class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :ending, dependent: :destroy
  has_many :comments, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_one_attached :image
  def get_profile_image(width, height)
    if image.attached?
      image.variant(resize_to_fill: [width, height]).processed
    else
      "people.jpg"
    end
  end
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :handle_name, presence: true
  validates :email_address, presence: true, uniqueness: true

end
