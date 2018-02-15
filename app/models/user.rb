class User < ApplicationRecord
  has_secure_password
   belongs_to :cohort
  has_many :authored_posts, class_name: "Post", foreign_key: "author_id", dependent: :destroy
  has_many :tags, through: :authored_posts
  has_many :fan_posts, foreign_key: "fan_id", dependent: :destroy
  has_many :liked_posts, class_name: "Post", through: :fan_posts

  validates :medium_username, :cohort_id, presence: true
  validates :medium_username, uniqueness: true
  validate :medium_username_is_valid





  def medium_username_is_valid
    url = "https://medium.com/@#{medium_username}/latest"
    headers = {Accept:'application/json'}
    response = RestClient.get(url, headers)
  rescue RestClient::NotFound
    errors.add(:medium_username, "is not a valid Medium Username")
  end

end
