class ExpensesController < ApplicationController
  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to root_path, notice: 'Expense successfully created.'
    else
      Rails.logger.info(@expense.errors.full_messages.to_sentence)
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def index
    # First, identify all relevant expenses IDs where the current user is involved either as payer or as a participant.
    user_expenses_ids = Expense.joins(expense_items: :expense_item_participants)
                               .where("expenses.paid_by_id = :user_id OR expense_item_participants.user_id = :user_id", user_id: current_user.id)
                               .pluck(:id).uniq!

    # Then, load these expenses with all their items and participants, including the participants' user details.
    @expenses = Expense.includes(expense_items: { expense_item_participants: :user })
                       .where(id: user_expenses_ids)            


  end

  private


  def expense_params
    params.require(:expense).permit(
      :title,
      :paid_by_id,
      :total_amount,
      :expense_date,
      expense_items_attributes: [
        :id,
        :title, 
        :amount,
        :equally_shared,
        :_destroy,
        expense_item_participants_attributes: [:id, :user_id, :amount, :_destroy]
      ]
    )
  end
end
