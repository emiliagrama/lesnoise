class AddXDocumentToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :x_document, :float
  end
end
