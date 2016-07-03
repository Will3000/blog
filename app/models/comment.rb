class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_one :rating, dependent: :destroy
  validates :body, presence: true
  # , uniqueness: true

end
