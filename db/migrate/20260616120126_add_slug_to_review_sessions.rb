class AddSlugToReviewSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :review_sessions, :slug, :string
  end
end
