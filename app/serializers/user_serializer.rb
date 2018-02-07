class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :medium_username, :github, :email, :cohort_id, :image_slug
  has_many :fan_posts, serializer: FanPostSerializer
  has_many :authored_posts, serializer: AuthoredPostSerializer
end
