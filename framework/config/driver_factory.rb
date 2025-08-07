require 'appium_lib'
require_relative 'config_manager.rb'

module DriverFactory
  def self.build_driver

    device = ConfigManager.device.downcase
    platform_defaults = case device
                        when 'android'
                          {
                            platformName: 'Android',
                            automationName: 'UiAutomator2'
                          }
                        when 'ios'
                          {
                            platformName: 'iOS',
                            automationName: 'XCUITest'
                          }
                        else
                          raise "Device not supported: #{ConfigManager.target}"
                        end

    base_caps = ConfigManager.capabilities || {}
    caps = platform_defaults.merge(base_caps)
    puts caps
    opts = {
      caps: caps,
      appium_lib: {
        server_url: ConfigManager.server_url
      }
    }

    Appium::Driver.new(opts, true)
  end
end