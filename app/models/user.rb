class User < ActiveRecord::Base
  PROVIDER_TWITTER = "twitter"

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  has_many :favourites, dependent: :destroy
  has_many :fav_posts, through: :favourites, source: :post

  has_secure_password
  mount_uploader :avatar, AvatarUploader

  EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true, unless:   :using_oauth?
  validates :last_name, presence: true, unless:   :using_oauth?
  validates :email, presence: true,
                    uniqueness: true,
                    format: EMAIL_REGEX, unless:   :using_oauth?

  validates :uid, uniqueness: { scope: :provider },if: :using_oauth?
  before_create :generate_api_key

  serialize :twitter_raw_data, Hash

  def using_oauth?
    uid.present? && provider.present?
  end

  def using_twitter?
    using_oauth? && provider == PROVIDER_TWITTER
  end
  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_or_create_from_twitter(twitter_data)
    user = User.where(uid: twitter_data["uid"], provider: twitter_data["provider"]).first
    user = create_from_twitter(twitter_data) unless user
    user
  end

  def self.create_from_twitter(twitter_data)
    user = User.new
    full_name = twitter_data["info"]["name"].split(" ")
    user.first_name       = full_name.first
    user.last_name        = full_name.last
    user.uid              = twitter_data["uid"]
    user.provider         = twitter_data["provider"]
    user.twitter_consumer_token    = twitter_data["credentials"]["token"]
    user.twitter_consumer_secret   = twitter_data["credentials"]["secret"]
    user.twitter_raw_data = twitter_data
    user.password         = SecureRandom.urlsafe_base64
    user.save!
    user
  end

  def generate_api_key
    # begin
    #   self.api_key = SecureRandom.urlsafe_base64
    # end while User.exists?(api_key: api_key)

    loop do
      self.api_key = SecureRandom.urlsafe_base64
      break unless User.exists?(api_key: api_key)
    end
  end

  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
