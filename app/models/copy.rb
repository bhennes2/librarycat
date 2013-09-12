class Copy < ActiveRecord::Base
  
  #Attributes
  attr_accessible :book_id, :cover, :more_information, :page_count, :place, :price, :publisher, :title
  
  #Associations
  belongs_to :book
  
end
