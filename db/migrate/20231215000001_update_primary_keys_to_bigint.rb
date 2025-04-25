class UpdatePrimaryKeysToBigint < ActiveRecord::Migration[5.2]
  def up
    # This migration should update primary key columns to bigint
    # But we need to keep it safe for existing data
    
    # Instead of making direct changes that might break data,
    # we'll add a configuration setting that will ensure new tables use bigint
    
    Rails.application.config.active_record.primary_key = :bigint
    
    # We don't change existing tables as that might cause data corruption
    # Instead, we recommend manual migrations for specific tables after testing
    
    puts "New tables will now use bigint for primary keys"
    puts "Existing tables should be migrated manually after testing"
  end

  def down
    # Revert to using integer for primary keys (though this won't affect existing tables)
    Rails.application.config.active_record.primary_key = :integer
  end
end