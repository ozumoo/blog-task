class CreateRatingsTable < ActiveRecord::Migration[6.0]
    def change
      create_table :ratings do |t|
        t.references :post, foreign_key: { on_delete: :cascade }
        t.integer :value, null: false
        t.timestamps
      end
    end
 end
  