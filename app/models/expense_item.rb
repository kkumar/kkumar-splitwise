class ExpenseItem < ApplicationRecord
  belongs_to :expense
  has_many :expense_item_participants
  has_many :users, through: :expense_item_participants
  accepts_nested_attributes_for :expense_item_participants
end
