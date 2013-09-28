require 'csv'
require 'nokogiri' 
require 'open-uri'

namespace :books do 
  
  task :upload => :environment do
    Book.destroy_all
    
    ["a_l", "m_z"].each do |file_name|
      file = File.open("public/data/#{file_name}.xml", "r")
      doc = Nokogiri::XML.parse(file)
      doc.xpath("//record").each do |record|
        book = Book.new
        copy = book.copies.build
        tags = []
        record.children.each do |field|
          if field['type'] == '650'
            names = field.children.select { |subfield| subfield['type'] == 'a' }.map { |subfield| subfield.content.split('--').first }
            tags = Tag.find_or_create_by_names(names: names.join(', '), tag_type: Tag.subject_type)
          else
            h = schema["#{field['type']}"]
            if h.present?
              field.children.each do |subfield|
                attr = h["#{subfield['type']}"]
                if attr.present?
                  if Book.instance_methods(true).include?(attr)
                    book.send("#{attr}=", subfield.content) 
                  else
                    copy.send("#{attr}=", subfield.content) 
                  end
                end
              end
            end
          end
        end
        
        copy.price = copy.price.gsub!('p', '') if copy.price
        book.book_type = book.call_number.split(' ').first if book.call_number
        copy.title = book.title
        book.tags = tags
        book.save
      end
      file.close      
    end
    puts 'Successfully uploaded old books'
  end
  
end

namespace :categories do
  
  task :upload => :environment do 
    CSV.foreach("public/data/categories.csv") do |row|
      tag = Tag.create(name: row[0], tag_type: Tag.category_type)
    end
    puts 'Successfully uploaded categories'
  end
  
end

def schema
  {
    "245" => {
      "a" => :title,
      "b" => :subtitle,
      "c" => :author
    },
    "260" => {
      "a" => :place,
      "b" => :publisher,
      "c" => :year
    },
    "300" => {
      "a" => :page_count,
      "c" => :cover
    },
    "440" => {
      "a" => :series
    }, 
    "500" => {
      "a" => :more_information
    },
    "650" => {
      "a" => :subject
    },
    "700" => {
      "a" => :illustrator
    },
    "852" => {
      "9" => :price,
      "h" => :call_number
    }
  }
end

# http://www.loc.gov/marc/bibliographic/