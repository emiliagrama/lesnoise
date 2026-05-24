class AddPagePathToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :page_path, :string
  end
end
