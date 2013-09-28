class Tag < ActiveRecord::Base
  
  #Attributes
  attr_accessible :name, :tag_type
  
  #Associations
  has_many :descriptors
  
  #Validations
  validates :name, :tag_type, presence: true
    
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
      names = params[:names].split(', ')
      names.each do |name|
        tag = Tag.find_by_name(name.downcase) || Tag.create(name: name.downcase, tag_type: params[:tag_type])
        tags.push(tag)
      end
    end
    tags
  end
  
  def self.all_capitalized_and_alphabetized
    Tag.order('name ASC').each { |tag| tag.name = tag.name.capitalize }
  end
  
end
