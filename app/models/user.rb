class User < ActiveRecord::Base
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :favourites, dependent: :destroy
  has_many :fav_posts, through: :favourite, source: :post

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def self.search(word)
    where("first_name = :word OR last_name = :word OR email = :word", {word: "#{word}"})
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
