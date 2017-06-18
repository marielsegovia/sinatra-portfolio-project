require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations pending. Run rake db:migrate to resolve the issue.'
end

run ApplicationController
