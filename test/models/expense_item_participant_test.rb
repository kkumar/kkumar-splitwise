require "test_helper"

class ExpenseItemParticipantTest < ActiveSupport::TestCase
  fixtures :users, :expenses, :expense_items, :expense_item_participants

  def setup
    @expense_item = expense_items(:sandwich)
    @user = users(:one)
    @participant = @expense_item.expense_item_participants.build(user_id: @user.id, amount: 5.0)
  end

  test "should be valid" do
    assert @participant.valid?
  end

end
