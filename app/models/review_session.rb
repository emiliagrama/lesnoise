class ReviewSession < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  before_validation :set_share_token, on: :create

  validates :name, :base_url, presence: true

  private

  def set_share_token
    self.share_token ||= SecureRandom.hex(16)
  end
end