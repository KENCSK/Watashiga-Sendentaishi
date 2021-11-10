class Charm < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :book_id, scope: :user_id
end
