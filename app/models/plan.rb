class Plan < ApplicationRecord
  belongs_to :user
  validates :destination, presence: true, length: { maximum: 20 }
end
