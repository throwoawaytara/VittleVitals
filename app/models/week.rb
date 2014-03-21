class Week < ActiveRecord::Base
  has_many :days
  belongs_to :user

  validates :date, presence: true

  validates_presence_of :user_id
end
