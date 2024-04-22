class CreditsToUserQuery
  def initialize(user)
    @user = user
  end

  def call
    ExpenseItem.joins(:expense_item_participants, :expense)
               .where(expenses: { paid_by: @user })
               .where.not(expense_item_participants: { user_id: @user.id })
               .group('expense_item_participants.user_id')
               .sum('expense_item_participants.amount')
  end
end