class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :fav_users, through: :favourites, source: :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true,
                    uniqueness: true,
                    length: { minimum: 7}
  validates :body , presence: true

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def self.sublist(offset_nums)
    offset(offset_nums).limit(10)
  end

  def body_snippet
    if self.body.length > 100
      self.body[0..99] + "..."
    else
      self.body
    end
  end

  def rand_color
    ["teach-me", "", "handyman", "pick-up-delivery"].sample
  end

  def favourited_by?(user)
    favourites.exists?(user: user)
  end

  def favourited_for(user)
    favourites.find_by_user_id user
  end
end
