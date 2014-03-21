class Week < ActiveRecord::Base
  has_many :days
  belongs_to :user

  validates :date, presence: true
end
