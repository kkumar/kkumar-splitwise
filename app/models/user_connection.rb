class UserConnection < ApplicationRecord
  belongs_to :user
  belongs_to :connection, class_name: 'User'
end
