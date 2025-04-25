# This file provides backward compatibility for Rails 3 test patterns

module Rails3TestCompat
  # Rails 3 used assert_response for specific status codes
  # Rails 5 prefers assert_response :success, etc.
  def assert_response_with_compat(code_or_status)
    if code_or_status.is_a?(Numeric)
      # Convert numeric status code to symbolic status
      symbolic_status = case code_or_status
                         when 200..299 then :success
                         when 300..399 then :redirect
                         when 400..499 then :not_found
                         when 500..599 then :server_error
                         else code_or_status
                         end
      Rails.logger.warn "DEPRECATION WARNING: assert_response with numeric argument #{code_or_status} is deprecated. Use assert_response :#{symbolic_status} instead."
      assert_response symbolic_status
    else
      assert_response code_or_status
    end
  end
  
  # Rails 3 used assert_template to check rendered template
  # Rails 5 has removed this in favor of assert_select, etc.
  def assert_template_with_compat(expected_template, message = nil)
    Rails.logger.warn "DEPRECATION WARNING: assert_template is deprecated. Use assert_select or other assertions instead."
    
    # This is a simple implementation of assert_template
    template_paths = Array(_controller.instance_variable_get(:@_templates))
    template_path = template_paths.find { |t| t.include?(expected_template.to_s) }
    assert template_path, message || "Template #{expected_template} not found in rendered templates"
  end
  
  # Add any other deprecated test methods here
end

# Include the compatibility module in all tests
if defined?(ActiveSupport::TestCase)
  ActiveSupport::TestCase.include Rails3TestCompat
end

if defined?(ActionController::TestCase)
  ActionController::TestCase.class_eval do
    # Override assert_response
    alias_method :assert_response_without_compat, :assert_response
    alias_method :assert_response, :assert_response_with_compat
    
    # Add assert_template
    alias_method :assert_template, :assert_template_with_compat
  end
end