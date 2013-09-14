module BooksHelper
  
  def print_list(list)
    list.map { |el| el.name }.join(', ')
  end
  
end
