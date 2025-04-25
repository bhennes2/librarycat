# This initializer provides backward compatibility for asset pipeline changes

# In Rails 3, jQuery was the default JavaScript library
# In Rails 5, we need to ensure it's properly included

# Make sure jQuery is loaded before other JavaScript
Rails.application.config.assets.precompile += %w( jquery.js jquery_ujs.js )

# Include all JavaScript files in vendor/assets/javascripts
Rails.application.config.assets.precompile += %w( *.js )

# Add any vendor styles
Rails.application.config.assets.precompile += %w( *.css )