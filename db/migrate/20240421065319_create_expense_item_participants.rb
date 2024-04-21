class CreateExpenseItemParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_item_participants do |t|
      t.references :expense_item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 15, scale: 2
      t.timestamps
    end
  end
end
