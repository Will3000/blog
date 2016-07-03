class Category < ActiveRecord::Base
  has_many :post
  validates :title, uniqueness: true, presence: true
end
