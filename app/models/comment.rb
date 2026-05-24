class Comment < ApplicationRecord
  belongs_to :review_session

  validates :body, :page_url, :page_path, :x_percent, presence: true
  validate :has_vertical_position

  private

  def has_vertical_position
    if y_percent.blank? && y_document.blank?
      errors.add(:base, "Comment must have a vertical position")
    end
  end
end