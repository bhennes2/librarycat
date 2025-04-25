# This initializer provides backward compatibility for deprecated render options

module ActionController
  class Base
    # In Rails 3, render :text was common
    # In Rails 5, it's deprecated in favor of render :plain
    def render_with_compat(*args, &block)
      options = args.first
      
      if options.is_a?(Hash) && options.key?(:text)
        Rails.logger.warn "DEPRECATION WARNING: render :text is deprecated. Use render :plain instead."
        options[:plain] = options.delete(:text)
      end
      
      if options.is_a?(Hash) && options.key?(:nothing)
        Rails.logger.warn "DEPRECATION WARNING: render :nothing is deprecated. Use head :ok instead."
        return head :ok if options[:nothing]
      end
      
      render_without_compat(*args, &block)
    end
    
    # Alias method chain
    alias_method :render_without_compat, :render
    alias_method :render, :render_with_compat
  end
end