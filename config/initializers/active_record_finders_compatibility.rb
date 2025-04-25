# This initializer provides backward compatibility for old ActiveRecord finder methods

module ActiveRecord
  class Base
    class << self
      # Rails 3 used find_all_by_* and find_by_* dynamic finders
      # Rails 5.2 doesn't have these methods
      def method_missing(method_name, *args, &block)
        if method_name.to_s =~ /^find_all_by_(.+)$/
          ActiveSupport::Deprecation.warn("find_all_by_* is deprecated. Use where(#{$1}: args) instead")
          where($1 => args.first)
        elsif method_name.to_s =~ /^find_by_(.+)$/
          ActiveSupport::Deprecation.warn("find_by_* is deprecated. Use find_by(#{$1}: args) instead")
          find_by($1 => args.first)
        elsif method_name.to_s =~ /^find_or_create_by_(.+)$/
          ActiveSupport::Deprecation.warn("find_or_create_by_* is deprecated. Use find_or_create_by(#{$1}: args) instead")
          find_or_create_by($1 => args.first)
        elsif method_name.to_s =~ /^find_or_initialize_by_(.+)$/
          ActiveSupport::Deprecation.warn("find_or_initialize_by_* is deprecated. Use find_or_initialize_by(#{$1}: args) instead")
          find_or_initialize_by($1 => args.first)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        method_name.to_s =~ /^find_(all_)?by_/ || super
      end
    end
  end
end