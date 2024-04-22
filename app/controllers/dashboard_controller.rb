class DashboardController < ApplicationController
  def index
    @expense = Expense.new
    @expense.expense_items.build
    @dashboard_data = DashboardCalculator.new(current_user).call
  end
end
