# This initializer provides backward compatibility for deprecated callback chains

module CallbackCompatibility
  def self.included(base)
    base.class_eval do
      # Rails 3 style callbacks that return false to halt the chain
      # In Rails 5, you need to throw(:abort) instead
      
      [:before_validation, :before_save, :before_create, :before_update, :before_destroy].each do |callback|
        orig_method = :"_run_#{callback}_callbacks"
        
        define_method :"_run_#{callback}_callbacks_with_compat" do |*args|
          halted = false
          
          # Override the callback chain to catch false returns
          send(:"_run_#{callback}_callbacks_without_compat") do |target, chain|
            chain.filter_callbacks do |callback|
              # Execute the callback and check if it returns false
              result = callback.call(target, *args)
              if result == false
                Rails.logger.warn "DEPRECATION WARNING: Returning false in a callback to halt the chain is deprecated. Use throw(:abort) instead."
                halted = true
                false # Stop the chain
              else
                true # Continue the chain
              end
            end
          end
          
          # If any callback returned false, return false to maintain Rails 3 behavior
          !halted
        end
        
        # Alias method chain
        alias_method :"_run_#{callback}_callbacks_without_compat", orig_method
        alias_method orig_method, :"_run_#{callback}_callbacks_with_compat"
      end
    end
  end
end

ActiveRecord::Base.include CallbackCompatibility