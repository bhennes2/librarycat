class AddBarCodeToCopy < ActiveRecord::Migration
  def change
    add_column :copies, :barcode, :string
  end
end
