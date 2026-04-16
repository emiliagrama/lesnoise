class Project < ApplicationRecord
  belongs_to :user
  has_many :review_sessions, dependent: :destroy

  validates :name, presence: true
end
