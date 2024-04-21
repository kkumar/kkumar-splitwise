class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses, foreign_key: 'paid_by_id'
  has_many :user_connections
  has_many :connections, through: :user_connections
  has_many :expense_item_participants
  has_many :expense_items, through: :expense_item_participants
  has_many :sent_settlements, class_name: 'Settlement', foreign_key: 'sender_id'
  has_many :received_settlements, class_name: 'Settlement', foreign_key: 'receiver_id'    
end
