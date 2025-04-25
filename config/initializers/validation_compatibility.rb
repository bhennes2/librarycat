# This initializer provides backward compatibility for deprecated validation syntax

module ActiveModel
  module Validations
    module ClassMethods
      # In Rails 3, validates_* methods could use :on => :save
      # In Rails 5, :on => :save is the default and has been removed as an option
      
      [:validates_presence_of, :validates_length_of, :validates_uniqueness_of, 
       :validates_format_of, :validates_numericality_of].each do |validator|
        
        orig_method = validator
        
        define_method :"#{validator}_with_compat" do |*args|
          options = args.extract_options!
          
          if options[:on] == :save
            Rails.logger.warn "DEPRECATION WARNING: :on => :save is deprecated and redundant. It is the default behavior."
            options.delete(:on)
          end
          
          send(:"#{validator}_without_compat", *args, options)
        end
        
        # Alias method chain
        alias_method :"#{validator}_without_compat", orig_method
        alias_method orig_method, :"#{validator}_with_compat"
      end
    end
  end
end