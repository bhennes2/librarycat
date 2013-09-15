require 'csv'

namespace :books do 
  
  task :upload => :environment do
    ["a_l", "m_z"].each do |file_name|
      file = File.open("public/data/#{file_name}.xml", "r")
      hash = Hash.from_xml(file.read)
      yaml = hash.to_yaml
      puts yaml
    end
  end
  
end


# http://www.loc.gov/marc/bibliographic/
# 
# "title" - 245A
# "subtitle" - 245B
# "call_number"
# "author" - 245C
# "illustrator"
# "series" - 440 subfield
# "book_type" - 650A--
# "more_information"
# 
# "title" - 245A
# "book_id"
# "publisher" - 260B
# "place" - 260A
# "page_count" - 300A
# "cover" - 300C
# "price" - 852(9)
# "more_information" - 260C (Year)