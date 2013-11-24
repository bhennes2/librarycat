module BooksHelper
  
  def print_list(list)
    list.map { |el| el.name.capitalize }.join('; ')
  end
  
  def form_print_list(list)
    print_list(list).length > 0 ? "#{print_list(list)} " : ""
  end
  
end
