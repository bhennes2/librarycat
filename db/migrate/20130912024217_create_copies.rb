class CreateCopies < ActiveRecord::Migration
  def change
    create_table :copies do |t|
      t.string :title
      t.integer :book_id
      t.string :publisher
      t.string :place
      t.integer :page_count
      t.string :cover
      t.string :price
      t.text :more_information

      t.timestamps
    end
  end
end
