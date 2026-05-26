class AddResolvedToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :resolved, :boolean, default: false, null: false
  end
end