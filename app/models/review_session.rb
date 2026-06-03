class ReviewSession < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  before_validation :set_share_token, on: :create

  validates :name, :base_url, presence: true

  validate :name_unique_for_user

  validates :base_url,
    format: {
      with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
      message: "must be a valid URL starting with http:// or https://"
    }

  private
  def name_unique_for_user
    return if name.blank? || project.blank?

    duplicate = ReviewSession
      .joins(:project)
      .where(projects: { user_id: project.user_id })
      .where("LOWER(review_sessions.name) = ?", name.downcase)
      .where.not(id: id)
      .exists?

    if duplicate
      errors.add(:name, "already exists")
    end
  end

  def set_share_token
    self.share_token ||= SecureRandom.hex(16)
  end
end