class ExpenseItem < ApplicationRecord
  after_save :calculate_equal_share, if: :equally_shared?

  belongs_to :expense
  has_many :expense_item_participants
  has_many :users, through: :expense_item_participants
  accepts_nested_attributes_for :expense_item_participants, reject_if: :all_blank, allow_destroy: true

  private

  def calculate_equal_share
    return unless amount.present? && amount > 0

    equal_share = amount / expense_item_participants.size
    expense_item_participants.each do |participant|
      participant.update(amount: equal_share)
    end
  end

  def equally_shared?
    equally_shared
  end
end
