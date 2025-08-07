require_relative '../../framework/spec/spec_helper'
require_relative '../resources/mobile_app.rb'
require 'allure-rspec'

RSpec.describe 'MercadoLibre Test Cases' do
  it 'Mercado Libre Test' do
    driver = DriverManager.driver
    logger = RSpec.configuration.logger
    mobile_app = nil
    logger.log_step('Open Mecardo Libre application', driver: driver) do
      mobile_app = MobileApp.new(DriverManager.driver)
    end
    logger.log_step('Enter product name in search bar', driver: driver) do
      mobile_app.mercado_libre_common_page.search('playstation 5')
    end
    logger.log_step('Open filter window', driver: driver) do
      mobile_app.mercado_libre_results_page.open_filter()
    end
    logger.log_step('Filter by condition: Condicíon: Nuevo', driver: driver) do
      mobile_app.mercado_libre_results_page.filter_by_condition('Nuevo')
    end
    logger.log_step('Filter by condition: Envíos: Local', driver: driver) do
      mobile_app.mercado_libre_results_page.swipe_on_filter_column('Envíos')
      mobile_app.mercado_libre_results_page.filter_by_location('Local')
    end
    logger.log_step('Filter by condition: Ordenar por: Mayor precio', driver: driver) do
      mobile_app.mercado_libre_results_page.swipe_on_filter_column('Ordenar por ')
      mobile_app.mercado_libre_results_page.filter_by_order('Mayor precio')
    end
    logger.log_step('Applying filters', driver: driver) do
      mobile_app.mercado_libre_results_page.click_on_see_results()
    end
    logger.log_step('Getting first five product prices', driver: driver) do
      actualProductPrices = mobile_app.mercado_libre_results_page.get_five_firsts_products_pricces()
      sortedProductPrices = actualProductPrices.sort.reverse
      expect(actualProductPrices).to eq(sortedProductPrices)
    end
  end
end