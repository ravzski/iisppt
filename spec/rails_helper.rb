ENV["RAILS_ENV"] ||= 'test'

require 'factory_girl_rails'

require 'simplecov'
SimpleCov.start :rails do
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Helpers", "app/helpers"
  add_group "Mailers", "app/mailers"
  add_group "Services", "app/services"
end



#require "codeclimate-test-reporter"
# require 'spec_helper'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'

#CodeClimate::TestReporter.start

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

#reduce IO overhead
Rails.logger.level = 4

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.order = "random"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
end


# FactoryGirl::SyntaxRunner.class_eval do
#   include ActionDispatch::TestProcess
# end