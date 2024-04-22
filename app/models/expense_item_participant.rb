class ExpenseItemParticipant < ApplicationRecord
  belongs_to :expense_item
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }


end
