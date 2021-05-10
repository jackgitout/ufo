class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.float :total
      t.boolean :status

      t.timestamps
    end
  end
end
