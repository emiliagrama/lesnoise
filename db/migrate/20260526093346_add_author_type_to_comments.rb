class AddAuthorTypeToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :author_type, :string, default: "client", null: false
  end
end