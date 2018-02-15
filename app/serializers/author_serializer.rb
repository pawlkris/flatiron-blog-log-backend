class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :medium_username, :cohort_id, :image_slug
end
