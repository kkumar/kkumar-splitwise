class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :title
      t.text :desc
      t.decimal :total_amount, precision: 15, scale: 2
      t.references :paid_by, null: false, foreign_key: { to_table: :users }
      t.date :expense_date
      t.timestamps
    end
  end
end
