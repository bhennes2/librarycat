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
  
  #Pagination
  paginates_per 50
  
  #Instance Methods
  def assign_descriptors
    tags.each { |tag| self.descriptors.create(tag_id: tag.id) }
  end
  
  def subjects_list
    subjects.map(&:name).each(&:capitalize!).join('; ')
  end
  
end
