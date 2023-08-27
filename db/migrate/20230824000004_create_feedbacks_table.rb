class CreateFeedbacksTable < ActiveRecord::Migration[6.0]
    def change
      create_table :feedbacks do |t|
        t.references :user, foreign_key: { on_delete: :cascade }
        t.references :post, foreign_key: { on_delete: :cascade }
        t.text :comment
        t.timestamps
      end
    end
  end
  