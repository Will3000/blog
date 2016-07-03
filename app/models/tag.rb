class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
  validates :name, uniqueness: true, presence: true
end
