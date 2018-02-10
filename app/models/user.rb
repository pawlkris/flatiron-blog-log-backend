class User < ApplicationRecord
  has_secure_password
  belongs_to :cohort
  has_many :authored_posts, class_name: "Post", foreign_key: "author_id", dependent: :destroy
  has_many :tags, through: :authored_posts
  has_many :fan_posts, foreign_key: "fan_id", dependent: :destroy
  has_many :liked_posts, class_name: "Post", through: :fan_posts

  validates :password_digest, :cohort_id, presence: true
  validates_format_of :email, {with: /@/}
  validate :medium_username_is_valid





  def medium_username_is_valid
    url = "https://medium.com/@#{medium_username}/latest"
    headers = {Accept:'application/json'}
    response = RestClient.get(url, headers)
  rescue RestClient::NotFound
    errors.add(:medium_username, ": not a valid Medium Username")
  end

end
