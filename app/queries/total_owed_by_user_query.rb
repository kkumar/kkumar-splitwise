class TotalOwedByUserQuery
  def initialize(user)
    @user = user
  end

  def call
    # Step 1: Identify Expense Items not paid by the user
    expense_items_not_paid_by_user = ExpenseItem
                                     .joins(:expense)
                                     .where.not(expenses: {paid_by_id: @user.id})
                                     .pluck(:id)  # Collect IDs for the next query

    # Step 2: Calculate the sum of the user's contributions to these Expense Items
    total_owed_by_user = ExpenseItemParticipant
                         .where(expense_item_id: expense_items_not_paid_by_user, user_id: @user.id)
                         .sum(:amount)

    total_owed_by_user
  end
end