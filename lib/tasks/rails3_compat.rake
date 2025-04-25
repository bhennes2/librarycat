# This file provides backward compatibility for Rails 3 rake tasks

namespace :db do
  # Rails 3 had db:test:prepare, which was removed in Rails 4+
  desc "Prepare the test database (compatible with Rails 3)"
  task test_prepare: [:environment, "db:test:load"] do
    # This task just depends on db:test:load, which is the Rails 5 equivalent
    puts "Using db:test:load instead of db:test:prepare (Rails 5 compatibility)"
  end
  
  # Load schema files in the old Rails 3 way
  namespace :schema do
    desc "Load a schema.rb file into the database (compatible with Rails 3)"
    task :load_with_compat => :environment do
      puts "Loading schema in Rails 3 compatibility mode"
      # Call the original task
      Rake::Task["db:schema:load"].invoke
    end
  end
end

# Alias for db:migrate:reset in Rails 3
desc "Drop, create, and migrate the database (Rails 3 compatibility)"
task :reset_db => ["db:drop", "db:create", "db:migrate"] do
  puts "Database has been reset"
end