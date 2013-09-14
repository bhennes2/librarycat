class Descriptor < ActiveRecord::Base
  
  #Attributes
  attr_accessible :book_id, :tag_id
  
  #Associations
  belongs_to :book
  belongs_to :tag
  
  #Validations
  validates :book_id, :uniqueness => { :scope => :tag_id }
  
end
