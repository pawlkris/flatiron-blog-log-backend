class User < ApplicationRecord
  has_secure_password
  belongs_to :cohort
  has_many :authored_posts, class_name: "Post", foreign_key: "author_id", dependent: :destroy
  has_many :tags, through: :authored_posts
  has_many :fan_posts, foreign_key: "fan_id", dependent: :destroy
  has_many :liked_posts, class_name: "Post", through: :fan_posts
end
