# This initializer provides backward compatibility for old Rails 3 scope syntax

module ActiveRecord
  class Base
    class << self
      # Rails 3 allowed scope without a callable object
      # In Rails 4+, a Proc is required
      def scope_with_compat(name, body, &block)
        if body.is_a?(Proc)
          scope_without_compat(name, body, &block)
        else
          # If body is not a Proc, wrap it in one
          Rails.logger.warn "DEPRECATION WARNING: Calling scope :#{name} without a callable object is deprecated. Use a Proc/lambda instead."
          scope_without_compat(name, -> { body }, &block)
        end
      end

      # Alias method chain
      alias_method :scope_without_compat, :scope
      alias_method :scope, :scope_with_compat
    end
  end
end