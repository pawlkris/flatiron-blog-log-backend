class FanPost < ApplicationRecord
  belongs_to :fan, class_name: "User"
  belongs_to :liked_post, class_name: "Post"
end
