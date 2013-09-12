class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.string :call_number
      t.string :author
      t.string :illustrator
      t.string :series
      t.string :book_type
      t.text :more_information

      t.timestamps
    end
  end
end
