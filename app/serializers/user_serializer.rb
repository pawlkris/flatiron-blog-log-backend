class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :medium_username, :github, :email, :cohort_id, :image_slug
  has_many :authored_posts
  has_many :liked_posts
  has_many :tags

end
