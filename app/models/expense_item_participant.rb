class ExpenseItemParticipant < ApplicationRecord
  belongs_to :expense_item
  belongs_to :user
end
