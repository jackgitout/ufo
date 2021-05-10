class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :category
      t.string :title
      t.float :unit_price
      t.integer :quantity
      t.text :description
      t.date :expiry_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
