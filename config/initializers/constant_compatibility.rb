# This initializer provides backward compatibility for deprecated constant lookup paths

# In Rails 3, top-level constants were often accessed directly
# In Rails 5, using proper namespace is required

module ConstantCompatibility
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def const_missing(name)
      # Check for common Rails 3 constants that have moved
      case name.to_s
      when 'MysqlAdapter'
        ActiveRecord::ConnectionAdapters::Mysql2Adapter
      when 'PostgreSQLAdapter'
        ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
      when 'AssociationCollection'
        ActiveRecord::Associations::CollectionProxy
      when 'NamedScope'
        ActiveRecord::Relation
      when 'ActiveSupport::JSON::Variable'
        Rails.logger.warn "DEPRECATION WARNING: ActiveSupport::JSON::Variable is deprecated and has no direct replacement"
        Class.new
      else
        super
      end
    end
  end
end

# Apply to common modules
ActiveRecord::Base.include ConstantCompatibility
ActiveModel::Base.include ConstantCompatibility if defined?(ActiveModel::Base)
ActionController::Base.include ConstantCompatibility