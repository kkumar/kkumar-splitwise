class Expense < ApplicationRecord
  after_initialize :set_default_expense_date, if: :new_record?
  
  belongs_to :paid_by, class_name: 'User'
  has_many :expense_items
  has_many :expense_item_participants, through: :expense_items
  accepts_nested_attributes_for :expense_items, reject_if: lambda { |attributes|
  # Reject if the item is a tax or tip with an amount of zero
    (attributes['title'] == 'Tax' || attributes['title'] == 'Tip') && attributes['amount'].to_f.zero?
  }, allow_destroy: true

  def unique_participants
    User.joins(expense_item_participants: :expense_item)
        .where(expense_items: { expense_id: id })
        .distinct
  end  

  private
  def set_default_expense_date
    self.expense_date ||= Date.today
  end

end
