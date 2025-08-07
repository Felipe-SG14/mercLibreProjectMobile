require 'appium_lib'
require_relative 'config_manager.rb'

module DriverFactory
  def self.build_driver
    # Android by default
    platform_defaults = { platformName: 'Android', automationName: 'UiAutomator2' }
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