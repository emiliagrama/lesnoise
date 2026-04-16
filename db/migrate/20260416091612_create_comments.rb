class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :review_session, null: false, foreign_key: true
      t.string :page_url
      t.string :author_name
      t.text :body
      t.decimal :x_percent
      t.decimal :y_percent
      t.string :status

      t.timestamps
    end
  end
end
