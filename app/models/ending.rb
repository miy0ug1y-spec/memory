class Ending < ApplicationRecord
  belongs_to :user
  belongs_to :post ,optional: true

  has_many_attached :images
end
