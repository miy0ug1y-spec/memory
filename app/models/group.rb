class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :group_memberships, dependent: :destroy

  has_many :approved_group_memberships, -> { approved }, class_name: "GroupMembership"
  
  has_many :members, through: :approved_group_memberships, source: :user

  has_many :group_messages, dependent: :destroy

  has_one_attached :image
  def get_group_image(width, height)
    if image.attached?
      image.variant(resize_to_fill: [width, height]).processed
    else
      "group_image.jpg"
    end
  end

  validates :name, presence: true

end
