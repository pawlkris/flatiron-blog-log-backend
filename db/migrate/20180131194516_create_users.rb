class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :medium_username
      t.string :github
      t.string :email
      t.string :password_digest
      t.belongs_to :cohort, foreign_key: true
      t.string :image_slug
      t.index :medium_username, unique: true

      t.timestamps
    end
  end
end
