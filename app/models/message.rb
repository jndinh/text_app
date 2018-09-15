class Message < ApplicationRecord
  validates :user, :text, presence: true
  validates :number, presence: true, length: { is: 12}
  phony_normalize :number, default_country_code: 'US'

end
