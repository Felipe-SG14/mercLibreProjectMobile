require 'rspec'
require_relative '../config/driver_manager'
require_relative '../config/config_manager'

RSpec.configure do |config|
  config.before(:each) do
    DriverManager.start
  end

  config.after(:each) do
    DriverManager.quit
  end
end