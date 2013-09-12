class Book < ActiveRecord::Base
  
  #Attributes
  attr_accessible :author, :book_type, :call_number, :illustrator, :more_information, :series, :subtitle, :title
  
  #Associations
  has_many :copies
  
end
