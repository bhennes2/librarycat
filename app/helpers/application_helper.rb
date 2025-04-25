module ApplicationHelper
  include CompatibilityHelper
  
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
  
  # Handle deprecated content_for usage
  def content_for_with_compat(name, content = nil, options = {}, &block)
    if name.to_s == 'head' && (content.present? || block_given?)
      Rails.logger.warn "DEPRECATION WARNING: content_for :head is deprecated. Use content_for :head_content instead."
      name = :head_content
    end
    
    content_for_without_compat(name, content, options, &block)
  end
  
  # Alias method chain
  alias_method :content_for_without_compat, :content_for
  alias_method :content_for, :content_for_with_compat
end