class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user


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
end
