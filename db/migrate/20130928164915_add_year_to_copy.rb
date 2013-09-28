class AddYearToCopy < ActiveRecord::Migration
  def change
    add_column :copies, :year, :string
  end
end
