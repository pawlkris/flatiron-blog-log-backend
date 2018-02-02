class CreateFanPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :fan_posts do |t|
      t.integer :fan_id
      t.integer :liked_post_id

      t.timestamps
    end
  end
end
