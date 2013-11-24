class Book < ActiveRecord::Base
  
  include PgSearch
  pg_search_scope :search_by_title, :against => :title
  pg_search_scope :search_by_author, :against => :author
  
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
  
  #Class Methods
  def self.search(params)
    Book.send("search_by_#{params[:filter] || :title }", *[params[:query]])
  end
  
  #Instance Methods
  def assign_descriptors
    existing_descriptors = self.descriptors
    new_descriptors = []
    tags.each do |tag| 
      new_descriptors.push(self.descriptors.create(tag_id: tag.id))
    end
    descriptors_to_be_removed = existing_descriptors.keep_if { |d| new_descriptors.index(d).nil? }
    descriptors_to_be_removed.each(&:destroy)
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
