class AddElementAnchorToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :element_selector, :string
    add_column :comments, :x_element, :float
    add_column :comments, :y_element, :float
  end
end
