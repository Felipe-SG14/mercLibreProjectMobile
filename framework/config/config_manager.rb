require 'yaml'

module ConfigManager
  SETTINGS_PATH = File.expand_path('../../../settings.yml', __FILE__)
  @config = YAML.load_file(SETTINGS_PATH)

  def self.server_url
    ENV['SERVER_URL'] || @config['server_url']
  end

  def self.capabilities
    base_caps = @config.reject { |k,_| ['server_url'].include?(k) }
    base_caps['udid'] = ENV['UDID'] if ENV['UDID']
    base_caps['app']        = ENV['APP'] if ENV['APP']
    base_caps['appPackage'] = ENV['APP_PACKAGE'] if ENV['APP_PACKAGE']
    base_caps['appActivity'] = ENV['APP_ACTIVITY'] if ENV['APP_ACTIVITY']

    if base_caps['app']
      base_caps.delete('appActivity')
    else
      base_caps.delete('app') # por si venía en YAML pero está vacío
    end

    base_caps
  end

end