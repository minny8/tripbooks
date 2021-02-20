class Event < ApplicationRecord
  belongs_to :plan
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :tel, allow_blank: true, format: { with: VALID_PHONE_REGEX }
  validate :end_time_is_after_the_start_time
  
  def end_time_is_after_the_start_time
    unless end_time.nil? || start_time.nil? then
      if end_time < start_time
        errors.add(:end_time, "開始時間より後の時間にすることはできません。")
      end
    end
  end
end
