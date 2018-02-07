class FanPostSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :liked_post, serializer: LikedPostSerializer
end
