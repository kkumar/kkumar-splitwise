class DebtsByUserQuery
  def initialize(user)
    @user = user
  end

  def call
    @user.expense_item_participants
         .joins(expense_item: :expense)
         .where.not(expenses: { paid_by_id: @user.id })
         .group('expenses.paid_by_id')
         .sum('expense_item_participants.amount')
  end
end