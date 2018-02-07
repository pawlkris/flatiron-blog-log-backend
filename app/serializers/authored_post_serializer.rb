class AuthoredPostSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :date, :claps, :reading_time
  has_many :fans, serializer: FanSerializer
  has_many :tags, serializer: TagSerializer
  belongs_to :author, serializer: AuthorSerializer
end
