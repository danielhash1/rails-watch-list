class RemoveColumnsFromBookmarks < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookmarks, :movie_id
    remove_column :bookmarks, :list_id
    add_reference :bookmarks, :movie, null: false, foreign_key: true
    add_reference :bookmarks, :list, null: false, foreign_key: true
  end
end
