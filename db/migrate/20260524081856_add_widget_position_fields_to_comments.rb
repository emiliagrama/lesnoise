class AddWidgetPositionFieldsToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :y_document, :float unless column_exists?(:comments, :y_document)
  end
end