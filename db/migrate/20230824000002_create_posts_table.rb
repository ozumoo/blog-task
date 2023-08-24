class CreatePostsTable < ActiveRecord::Migration[6.0]
    def change
      create_table :posts do |t|
        t.references :user, foreign_key: true
        t.string :title, null: false
        t.text :content, null: false
        t.string :author_ip, null: false
        t.timestamps
      end
    end
  end
  