class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  scope :published, -> { where(is_publish: true) }
  
  validates :title, presence: true
  validates :body, presence: true
  validates :is_publish, inclusion: { in: [true, false] }
   def within_one_week?
    created_at >= 1.week.ago
   end

end
