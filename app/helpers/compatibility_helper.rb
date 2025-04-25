module CompatibilityHelper
  # In Rails 3, the error_messages_for helper was common
  # In Rails 5, it's gone
  def error_messages_for(object, options = {})
    return '' if object.errors.empty?

    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join("\n")

    html = <<-HTML
    <div class="error_messages">
      <h2>#{options[:header_message] || 'The following errors prohibited this form from being saved:'}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
  
  # Mimic the old Rails 3 link_to_function helper
  def link_to_function(name, function, html_options = {})
    onclick = "#{function}; return false;"
    href = html_options[:href] || '#'
    
    # Rails 5 warns about generating JS in views, but this is for compatibility
    Rails.logger.warn "DEPRECATION WARNING: link_to_function is deprecated. Use JavaScript event handlers instead."
    
    link_to(name, href, html_options.merge(onclick: onclick))
  end
  
  # Mimic the old Rails 3 button_to_function helper
  def button_to_function(name, function, html_options = {})
    onclick = "#{function}; return false;"
    
    # Rails 5 warns about generating JS in views, but this is for compatibility
    Rails.logger.warn "DEPRECATION WARNING: button_to_function is deprecated. Use JavaScript event handlers instead."
    
    button_tag(name, html_options.merge(type: 'button', onclick: onclick))
  end
end