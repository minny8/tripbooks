class Plan < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  validates :destination, presence: true, length: { maximum: 20 }
  validate :return_date_is_after_the_return_date
  
  
  def return_date_is_after_the_return_date
    if return_date < departure_date
      errors.add(:return_date, "出発日より前の日付にすることはできません。")
    end
  end
end
