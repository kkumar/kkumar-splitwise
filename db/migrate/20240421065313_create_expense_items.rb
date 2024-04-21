class CreateExpenseItems < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_items do |t|
      t.references :expense, null: false, foreign_key: true
      t.string :title
      t.decimal :amount, precision: 15, scale: 2
      t.boolean :equally_shared, default: true
      t.timestamps
    end
  end
end
