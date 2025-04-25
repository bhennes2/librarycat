# Configure Rails 5 autoloading to be more compatible with Rails 3 patterns

# Tell Rails not to complain about classes or modules not matching filenames
ActiveSupport::Dependencies.explicitly_unloadable_constants = []

# Allow loading from subdirectories without proper namespaces (Rails 3 style)
Rails.application.config.to_prepare do
  # Add lib directory to load path
  lib_path = Rails.root.join('lib')
  $LOAD_PATH.unshift(lib_path.to_s) unless $LOAD_PATH.include?(lib_path.to_s)
  
  # Autoload common directories
  %w[app/services app/presenters app/decorators app/values app/forms].each do |dir|
    path = Rails.root.join(dir)
    ActiveSupport::Dependencies.autoload_paths << path.to_s if path.exist?
  end
end