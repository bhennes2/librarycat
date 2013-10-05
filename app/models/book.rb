class Book < ActiveRecord::Base
  
  #Attributes
  attr_accessible :author, :book_type, :call_number, :illustrator, :more_information, :series, :subtitle, :title
  attr_accessor :tags
  
  #Associations
  has_many :copies, dependent: :destroy
  has_many :descriptors, dependent: :destroy
  has_many :subjects, through: :descriptors, source: :tag, conditions: { tag_type: Tag.subject_type }
  has_many :categories, through: :descriptors, source: :tag, conditions: { tag_type: Tag.category_type }
  
  #Callbacks
  after_save :assign_descriptors
  before_save :assign_sortable_title
  
  #Pagination
  paginates_per 50
  
  #Instance Methods
  def assign_descriptors
    tags.each { |tag| self.descriptors.create(tag_id: tag.id) } if tags.present?
  end
  
  def assign_sortable_title
    if title
      string_array = title.split(' ')
      first_element = string_array.first.sub(/(the|a|an)/i, '')
      string_array[0] = first_element
      self.sortable_title = string_array.select(&:present?).join(' ')
    end
  end
  

  
end
