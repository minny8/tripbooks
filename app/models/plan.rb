class Plan < ApplicationRecord
  belongs_to :user
  has_many :events
  validates :destination, presence: true, length: { maximum: 20 }
end
