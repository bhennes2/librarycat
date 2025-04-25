# Rails Upgrade Toolbox - Utilities to help diagnose Rails 3 to 5 upgrade issues

module RailsUpgradeToolbox
  class << self
    def analyze_deprecation_warnings
      puts "Analyzing deprecation warnings in the log..."
      log_file = Rails.root.join('log', "#{Rails.env}.log")
      
      unless File.exist?(log_file)
        puts "Log file not found: #{log_file}"
        return
      end
      
      deprecations = {}
      
      File.readlines(log_file).each do |line|
        if line.include?('DEPRECATION WARNING')
          # Extract the deprecation message
          message = line.split('DEPRECATION WARNING:').last.strip
          deprecations[message] ||= 0
          deprecations[message] += 1
        end
      end
      
      if deprecations.empty?
        puts "No deprecation warnings found in the log."
      else
        puts "Found #{deprecations.size} unique deprecation warnings:"
        
        deprecations.sort_by { |_, count| -count }.each do |message, count|
          puts "- [#{count}x] #{message}"
        end
      end
    end
    
    def check_common_issues
      puts "Checking for common Rails 3 to 5 upgrade issues..."
      
      # Check for attr_accessible usage in models
      check_attr_accessible
      
      # Check for old finder methods
      check_old_finders
      
      # Check for old render syntax
      check_old_render_syntax
      
      # Check for before_filter usage
      check_before_filter
      
      puts "Finished checking for common issues."
    end
    
    private
    
    def check_attr_accessible
      puts "Checking for attr_accessible usage in models..."
      models_dir = Rails.root.join('app', 'models')
      
      if Dir.exist?(models_dir)
        count = 0
        Dir.glob(File.join(models_dir, '**', '*.rb')).each do |file|
          if File.read(file).match(/attr_accessible/)
            count += 1
            puts "- Found attr_accessible in #{file.gsub(Rails.root.to_s, '')}"
          end
        end
        
        if count == 0
          puts "  No attr_accessible usages found."
        else
          puts "  Found #{count} files using attr_accessible. These should be migrated to strong parameters."
        end
      end
    end
    
    def check_old_finders
      puts "Checking for old ActiveRecord finder methods..."
      all_rb_files = Dir.glob(Rails.root.join('app', '**', '*.rb'))
      
      count = 0
      all_rb_files.each do |file|
        content = File.read(file)
        if content.match(/find_by_\w+|find_all_by_\w+|find_or_create_by_\w+|find_or_initialize_by_\w+|scoped_by_\w+/)
          count += 1
          puts "- Found old finder methods in #{file.gsub(Rails.root.to_s, '')}"
        end
      end
      
      if count == 0
        puts "  No old finder methods found."
      else
        puts "  Found #{count} files using old finder methods. These should be updated to the new syntax."
      end
    end
    
    def check_old_render_syntax
      puts "Checking for old render syntax..."
      controllers_dir = Rails.root.join('app', 'controllers')
      views_dir = Rails.root.join('app', 'views')
      
      count = 0
      [controllers_dir, views_dir].each do |dir|
        if Dir.exist?(dir)
          Dir.glob(File.join(dir, '**', '*.rb')).each do |file|
            content = File.read(file)
            if content.match(/render\s+:text|render\s+:nothing|render\s+:inline/)
              count += 1
              puts "- Found old render syntax in #{file.gsub(Rails.root.to_s, '')}"
            end
          end
        end
      end
      
      if count == 0
        puts "  No old render syntax found."
      else
        puts "  Found #{count} files using old render syntax. These should be updated to the new syntax."
      end
    end
    
    def check_before_filter
      puts "Checking for before_filter usage..."
      controllers_dir = Rails.root.join('app', 'controllers')
      
      if Dir.exist?(controllers_dir)
        count = 0
        Dir.glob(File.join(controllers_dir, '**', '*.rb')).each do |file|
          if File.read(file).match(/before_filter/)
            count += 1
            puts "- Found before_filter in #{file.gsub(Rails.root.to_s, '')}"
          end
        end
        
        if count == 0
          puts "  No before_filter usages found."
        else
          puts "  Found #{count} files using before_filter. These should be changed to before_action."
        end
      end
    end
  end
end

# Add a Rake task to run these checks
namespace :rails_upgrade do
  desc "Analyze deprecation warnings in the log"
  task analyze_deprecations: :environment do
    RailsUpgradeToolbox.analyze_deprecation_warnings
  end
  
  desc "Check for common Rails 3 to 5 upgrade issues"
  task check_issues: :environment do
    RailsUpgradeToolbox.check_common_issues
  end
  
  desc "Run all Rails upgrade checks"
  task all: [:analyze_deprecations, :check_issues]
end