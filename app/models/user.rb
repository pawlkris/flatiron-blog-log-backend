class User < ApplicationRecord
  has_secure_password
  belongs_to :cohort
  has_many :authored_posts, class_name: "Post", foreign_key: "author_id"
end
