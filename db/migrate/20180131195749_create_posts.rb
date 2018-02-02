class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.datetime :date
      t.integer :claps
      t.integer :reading_time
      t.integer :author_id

      t.timestamps
    end
  end
end
