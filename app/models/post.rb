class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  scope :published, -> { where(is_publish: true) }
  
  validates :title, presence: true
  validates :body, presence: true
end
