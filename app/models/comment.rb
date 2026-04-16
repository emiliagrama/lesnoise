class Comment < ApplicationRecord
  belongs_to :review_session

  validates :body, :page_url, presence: true
end
