class Expense < ApplicationRecord
  belongs_to :paid_by, class_name: 'User'
  has_many :expense_items
  has_many :expense_item_participants, through: :expense_items
  accepts_nested_attributes_for :expense_items
end
