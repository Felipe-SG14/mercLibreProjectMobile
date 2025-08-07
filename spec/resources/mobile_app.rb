require_relative '../../framework/elements/mobile_actions'
Dir[File.join(__dir__, '../pageObjects', '*.rb')].each { |file| require_relative file }

class MobileApp
  def initialize(driver)
    @mobile_actions = MobileActions.new(driver)
  end

  def mercado_libre_common_page
    @mercado_libre_common_page ||= MercadoLibreCommonPage.new(@mobile_actions)
  end

  def mercado_libre_results_page
    @mercado_libre_results_page ||= MercadoLibreResultsPage.new(@mobile_actions)
  end

end