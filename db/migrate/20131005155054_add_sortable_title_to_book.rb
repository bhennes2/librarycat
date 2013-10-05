class AddSortableTitleToBook < ActiveRecord::Migration
  def change
    add_column :books, :sortable_title, :string
  end
end
