require 'active_record'

ActiveRecord::Schema.define(version: 2023_08_28_000000) do
    create_table 'posts', force: :cascade do |t|
      t.string 'title'
      t.text 'content'
      t.string 'author_ip'
      t.bigint 'user_id'
      t.decimal 'average_rating', precision: 5, scale: 2
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  
    create_table 'users', force: :cascade do |t|
      t.string 'email'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  
    create_table 'ratings', force: :cascade do |t|
      t.bigint 'post_id'
      t.integer 'value'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  
    create_table 'feedbacks', force: :cascade do |t|
      t.bigint 'user_id'
      t.text 'comment'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  
    add_index 'ratings', ['post_id'], name: 'index_ratings_on_post_id'
    add_index 'feedbacks', ['user_id'], name: 'index_feedbacks_on_user_id'
  end
  