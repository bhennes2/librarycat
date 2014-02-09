class Tag < ActiveRecord::Base
  
  #Attributes
  attr_accessible :name, :tag_type
  
  #Associations
  has_many :descriptors, dependent: :destroy
  has_many :books, through: :descriptors
  
  #Validations
  validates :name, :tag_type, presence: true
  validates :name, uniqueness: { scope: :tag_type }
    
  #Class Method
  def self.subject_type
    'subject'
  end
  
  def self.category_type
    'category'
  end
  
  def self.find_or_create_by_names(params)
    tags = []
    if params[:names]
      names = params[:names].split('; ')
      names.each do |name|
        tag = Tag.where(name: name.downcase, tag_type: params[:tag_type]).first || Tag.create(name: name.downcase, tag_type: params[:tag_type])
        tags.push(tag)
      end
    end
    tags
  end
  
  def self.all_capitalized_and_alphabetized
    Tag.order('name ASC').each { |tag| tag.name = tag.name.capitalize }
  end
  
end
