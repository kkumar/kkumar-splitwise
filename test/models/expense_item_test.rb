require "test_helper"

class ExpenseItemTest < ActiveSupport::TestCase
  fixtures :users, :expenses, :expense_items

  def setup
    @expense = expenses(:coffee)
    @expense_item = @expense.expense_items.build(title: "Coffee", amount: 5.0)
  end

  test "should be valid" do
    assert @expense_item.valid?
  end

  test "title should be present" do
    @expense_item.title = " "
    assert_not @expense_item.valid?
  end

  test "amount should be positive" do
    @expense_item.amount = -1
    assert_not @expense_item.valid?
  end
end
