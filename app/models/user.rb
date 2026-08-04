class User < ApplicationRecord
  
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :ending, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_messages, dependent: :destroy
  
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :active_relationships,
    class_name: "Relationship",
    foreign_key: "follower_id",
    dependent: :destroy

  has_many :following,
    through: :active_relationships,
    source: :followed

  has_many :passive_relationships,
    class_name: "Relationship",
    foreign_key: "followed_id",
    dependent: :destroy

  has_many :followers,
    through: :passive_relationships,
    source: :follower

  enum :gender, {
    undisclosed: 0,
    male: 1,
    female: 2
  }
  def gender_japanese
    case gender
    when "undisclosed"
      "(性別回答なし)"
    when "male"
      "(男性)"
    when "female"
      "(女性)"
    end
  end


  has_one_attached :image
  def get_profile_image(width, height)
    if image.attached?
      image.variant(resize_to_fill: [width, height]).processed
    else
      "people.jpg"
    end
  end

  has_many :owned_groups, 
            class_name: "Group",
            foreign_key: "owner_id",
            dependent: :destroy
            
  has_many :group_memberships,
            dependent: :destroy

  has_many :approved_group_memberships,
            -> { approved },
            class_name: "GroupMembership"

  has_many :joined_groups,
            through: :approved_group_memberships,
            source: :group

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :handle_name, presence: true
  validates :email_address, presence: true, uniqueness: true

end
