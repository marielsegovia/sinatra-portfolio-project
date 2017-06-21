require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations pending. Run rake db:migrate to resolve the issue.'
end

use Rack::MethodOverride
use BooksController
use UsersController
run ApplicationController
