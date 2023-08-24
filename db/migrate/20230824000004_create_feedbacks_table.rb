class CreateFeedbacksTable < ActiveRecord::Migration[6.0]
    def change
      create_table :feedbacks do |t|
        t.references :owner, references: :users, foreign_key: { to_table: :users }
        t.references :user, foreign_key: true
        t.references :post, foreign_key: true
        t.text :comment
        t.integer :rating
        t.string :feedback_type
        t.timestamps
      end
    end
  end
  