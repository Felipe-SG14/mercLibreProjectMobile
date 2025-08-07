require_relative 'driver_factory'
require_relative 'config_manager'

module DriverManager
  @driver = nil

  class << self
    def start
      return @driver if @driver

      @driver = DriverFactory.build_driver
      Appium.promote_appium_methods Object
      @driver.start_driver
    end

    def driver
      @driver
    end

    def quit
      @driver&.terminate_app(ConfigManager.capabilities['appPackage'])
      @driver&.driver_quit
      @driver = nil
    end
  end
end