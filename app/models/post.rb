class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :fan_posts, foreign_key: "liked_post_id"
  has_many :fans, class_name:"User", through: :fan_posts
end
