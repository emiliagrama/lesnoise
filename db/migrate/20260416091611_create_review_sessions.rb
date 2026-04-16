class CreateReviewSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :review_sessions do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.string :base_url
      t.string :share_token
      t.string :status

      t.timestamps
    end
  end
end
