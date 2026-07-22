class EndingPost < ApplicationRecord
  belongs_to :ending
  belongs_to :post, optional: true
end
