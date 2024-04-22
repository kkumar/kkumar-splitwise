class UserExpensesService
  def initialize(user)
    @user = user
  end

  def call
    Expense.includes(:expense_items)
           .left_joins(expense_items: :expense_item_participants)
           .where('expenses.paid_by_id = :user_id OR expense_item_participants.user_id = :user_id', user_id: @user.id)
           .distinct
  end
end