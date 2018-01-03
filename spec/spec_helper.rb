RSpec.configure do |config|
  require 'rspec/rails'
  require 'pundit/rspec'
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

end
