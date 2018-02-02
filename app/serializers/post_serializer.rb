class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :date, :claps, :reading_time
  belongs_to :author
  has_many :fans
  has_many :tags
end
