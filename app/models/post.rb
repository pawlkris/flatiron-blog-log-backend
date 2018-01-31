class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :post_tags
  has_many :tags, through: :post_tags
end
