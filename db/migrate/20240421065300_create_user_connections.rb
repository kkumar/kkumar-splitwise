class CreateUserConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :user_connections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :connection, null: false, foreign_key: { to_table: :users }
      t.string :status
      t.timestamps
    end
  end
end
