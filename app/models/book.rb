class Book < ActiveRecord::Base

  include PgSearch
  pg_search_scope :search_by_title, :against => :title
  pg_search_scope :search_by_author, :against => :author
  pg_search_scope :search_by_subject, :associated_against => { :subjects => :name }
  pg_search_scope :search_by_category, :associated_against => { :subjects => :name }

  #Validations
  validates :title, presence: true

  #Associations
  has_many :copies, dependent: :destroy
  has_many :descriptors, dependent: :destroy
  has_many :subjects, through: :descriptors, source: :tag, conditions: { tag_type: Tag.subject_type }
  has_many :categories, through: :descriptors, source: :tag, conditions: { tag_type: Tag.category_type }

  #Attributes
  attr_accessible :author, :book_type, :call_number, :illustrator, :more_information, :series, :subtitle, :title,
                  :subject_ids, :category_ids, :copies_attributes, :subjects_names, :categories_names
  attr_accessor :tags, :subjects_names, :categories_names
  accepts_nested_attributes_for :copies

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
    [:subject_ids, :category_ids].each do |attrs|
      arr = (self.send(attrs) || []).map { |id| self.descriptors.where(tag_id: id).first || self.descriptors.create(tag_id: id) }
      new_descriptors.concat(arr)
    end
    [:subjects_names, :categories_names].each do |attrs|
      arr = []
      (self.send(attrs) || "").split('; ').each do |name|
        tag_type = attrs == :subject_names ? Tag.subject_type : Tag.category_type
        tag = Tag.find_by_name(name) || Tag.create(name: name, tag_type: tag_type)
        arr.push(self.descriptors.create(tag_id: tag.id))
      end
      new_descriptors.concat(arr)
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
