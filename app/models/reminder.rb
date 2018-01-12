class Reminder < ApplicationRecord
  belongs_to :user
  validates :purpose, :reminder_date, :user_id, presence: true
end
