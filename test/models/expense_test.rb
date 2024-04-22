require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
  fixtures :users, :expenses
  def setup
    @user = users(:one)
    @expense = Expense.new(title: "Lunch Meeting", expense_date: Date.today, paid_by_id: @user.id, total_amount: 100.0)
  end

  test "should be valid" do
    assert @expense.valid?
  end

  test "title should be present" do
    @expense.title = " "
    assert_not @expense.valid?
  end

  test "expense date should be present" do
    @expense.expense_date = nil
    assert_not @expense.valid?
  end
end
