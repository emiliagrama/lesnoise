class Comment < ApplicationRecord
  belongs_to :review_session

  validates :body, :page_url, :page_path, presence: true
  validates :x_percent, :y_document, presence: true
end
