require 'rspec'
require 'allure-rspec'
require_relative '../config/driver_manager'
require_relative '../config/config_manager'
require_relative '../helpers/log_manager.rb'

$step_logger = StepLogger.new

RSpec.configure do |config|

  config.before(:each) do
    DriverManager.start
    DriverManager.driver.set_clipboard(content: '', content_type: :plaintext)
    config.add_setting(:logger, default: $step_logger)
  end

  config.after(:each) do
    DriverManager.quit
  end

  config.after(:suite) do
    $step_logger.generate_report
  end
end