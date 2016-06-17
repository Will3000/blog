class Category < ActiveRecord::Base
  has_many :post
  validates :title, presence: true
end
