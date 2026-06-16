class ReviewSession < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  before_validation :set_share_token, on: :create
  before_validation :generate_slug, on: :create

  validates :name, :base_url, presence: true, length: { maximum: 30 }
  validates :slug, presence: true, uniqueness: true

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

  def generate_slug
    return if self.slug.present?

    base = name.to_s.parameterize
    base = "review" if base.blank?

    candidate = base
    counter = 2

    while ReviewSession.exists?(slug: candidate)
      candidate = "#{base}-#{counter}"
      counter += 1
    end

    self.slug = candidate
  end
end