class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :date, :claps, :reading_time
  belongs_to :author, serializer: AuthorSerializer
  has_many :fans, serializer: FanSerializer
  has_many :tags
end
