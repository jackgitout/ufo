class ChangeColumnNames < ActiveRecord::Migration[6.0]
  def change
    remove_reference :order_items, :transaction
    rename_table :transactions, :orders
    add_reference :order_items, :order, foreign_key: true
  end
end
