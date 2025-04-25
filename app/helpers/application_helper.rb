module ApplicationHelper
  # Add common helper methods used across your application
  
  # Example: Format date in a consistent way
  def format_date(date)
    date.strftime("%B %d, %Y") if date.present?
  end
  
  # Example: Create a page title
  def page_title(title = nil)
    if title.present?
      "#{title} | Your App Name"
    else
      "Your App Name"
    end
  end
end