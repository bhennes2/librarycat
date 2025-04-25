# This initializer provides backward compatibility for deprecated URL/Path helper access

# In Rails 3, path helpers were often called directly in models
# In Rails 5, this is discouraged and models don't have direct access

# Add URL helpers to ActiveRecord models 
ActiveSupport.on_load(:active_record) do
  include Rails.application.routes.url_helpers
end