class LikedPostSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :date
  belongs_to :author, serializer: AuthorSerializer
  has_many :tags, serializer: TagSerializer
end
