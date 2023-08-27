class CreatePostsTable < ActiveRecord::Migration[6.0]
    def change
      create_table :posts do |t|
        t.references :user, foreign_key: { on_delete: :cascade }
        t.string :title, null: false
        t.text :content, null: false
        t.string :author_ip, null: false
        t.float :average_rating, null:true
        t.timestamps
      end
    end
  end
  