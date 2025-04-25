# This initializer helps migrate from attr_accessible to strong parameters
# It provides backward compatibility for models still using the old Rails 3 way

ActiveSupport.on_load(:active_record) do
  # Define attr_accessible at runtime for backward compatibility
  unless respond_to?(:attr_accessible)
    def self.attr_accessible(*args)
      # In Rails 5.2, we simply log a deprecation warning
      # and the parameters will be managed by strong_parameters in controllers
      args.each do |arg|
        Rails.logger.warn "DEPRECATION WARNING: Model #{self.name} uses attr_accessible for #{arg}, please migrate to strong parameters"
      end
    end
  end
end