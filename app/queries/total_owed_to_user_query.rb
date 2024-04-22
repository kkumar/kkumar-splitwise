class TotalOwedToUserQuery
  def initialize(user)
    @user = user
  end


  def call
    @expense_items = ExpenseItem.joins(:expense)
                                .where(expenses: { paid_by_id: @user.id })
    # Step 1: Sum of amounts for ExpenseItems paid by the user
    expense_items_ids = ExpenseItem.joins(:expense)
                                   .where(expenses: { paid_by_id: @user.id })
                                   .pluck(:id)
    expense_items_sum = ExpenseItem.where(id: expense_items_ids).sum(:amount)

    # Step 2: Sum of the user's contributions as a participant in these ExpenseItems
    expense_item_participant_sum = ExpenseItemParticipant.where(expense_item_id: expense_items_ids, user_id: @user.id).sum(:amount)

    # Step 3: Calculate the net amount owed to the user
    total_owed_to_user = expense_items_sum - expense_item_participant_sum

    total_owed_to_user                                
  end

  # def call
  #   Expense.where(paid_by: @user)
  #          .joins(:expense_items)
  #          .where.not(
  #            id: Expense.joins(expense_items: :expense_item_participants)
  #                       .where(expense_items: {expense: {paid_by: @user}})
  #                       .group(:id)
  #                       .having('COUNT(expense_item_participants.user_id) = 1 AND BOOL_AND(expense_item_participants.user_id = ?)', @user.id)
  #          )
  #          .sum('expense_items.amount')
  # end
end