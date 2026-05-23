class AddPositionFieldsToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :y_document, :integer
    add_column :comments, :viewport_width, :integer
    add_column :comments, :viewport_height, :integer
  end
end
