class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def validate_checkout_dates_cannot_be_in_the_past
    if checkout.present? && checkout < checkin
      errors.add(:checkout,"はチェックイン日より前の日付は設定できません")
    end
  end

  def validate_checkin_dates_cannot_be_in_the_past
    if checkin.present? && checkin < Date.today
      errors.add(:checkin,"は本日より前の日付を設定できません")
    end
  end

  with_options presence: true do
    validates :checkin
    validates :checkout
    validates :people, numericality: {only_integer: true, greater_than_or_equal_to: 1 }, length: { maximum: 2 }
    validates :user_id
    validates :room_id
  end

  validate :validate_checkin_dates_cannot_be_in_the_past
  validate :validate_checkout_dates_cannot_be_in_the_past

  def stay_days
    checkout - checkin
  end
end
