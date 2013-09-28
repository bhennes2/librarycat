class Copy < ActiveRecord::Base
  
  #Attributes
  attr_accessible :book_id, :cover, :more_information, :page_count, :place, :price, :publisher, :title, :year, :barcode
  
  #Associations
  belongs_to :book
  
  #Instance Method
  def formatted_page_count
    page_count == 0 ? 'unpaginated' : "#{page_count} pp"
  end
  
end
