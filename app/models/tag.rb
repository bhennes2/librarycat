class Tag < ActiveRecord::Base
  
  #Attributes
  attr_accessible :name, :tag_type
  
  #Associations
  has_many :descriptors
    
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
      puts names
      names.each do |name|
        tag = Tag.find_by_name(name) || Tag.create(name: name, tag_type: params[:tag_type])
        tags.push(tag)
      end
    end
    tags
  end
  
end
