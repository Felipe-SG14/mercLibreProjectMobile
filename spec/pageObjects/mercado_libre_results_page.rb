require 'rspec'

class MercadoLibreResultsPage < MercadoLibreCommonPage

  def initialize(mobile_actions)
    super(mobile_actions)

    @filter_button = MobileElementBuilder.new
                      .with_type(:xpath)
                      .with_value('//android.widget.TextView[contains(@text, "Filtros")]')
                      .build

    @filter_column = MobileElementBuilder.new
                      .with_type(:xpath)
                      .with_value('//android.widget.ListView[@resource-id="selectable"]')
                      .build

    @see_results_button = MobileElementBuilder.new
                      .with_type(:clickable)
                      .with_type(:xpath)
                      .with_value("//android.widget.Button[contains(@text,'resultados')]")
                      .build

    @search_results_body = MobileElementBuilder.new
                      .with_type(:id)
                      .with_value("com.mercadolibre:id/search_component_compose_view")
                      .build

    @first_five_product_names = MobileElementBuilder.new
                      .with_type(:xpath)
                      .with_value("(//android.view.View//android.widget.TextView[1])[position() <= 5]")
                      .build

    @first_five_product_prices = MobileElementBuilder.new
                      .with_type(:xpath)
                      .with_value("(//android.view.View//android.widget.TextView[1]/following-sibling::android.widget.TextView[contains(@content-desc, 'Pesos') and not(contains(@content-desc, 'Antes')) and not(contains(@content-desc, 'meses'))])[position() <= 5]")
                      .build
                  
  end
  
  def open_filter()
    @mobile_actions.click(@filter_button)
  end

  def filter_by_condition(filter_value)
    condition_id = 'Condición'
    filter_criteria_button = MobileElementBuilder.new
                      .with_type(:accessibility_id)
                      .with_value(condition_id)
                      .with_wait(:clickable)
                      .build
    filter_value_button = MobileElementBuilder.new
                      .with_type(:xpath)
                      .with_value("//android.view.View[contains(@resource-id, 'component-#{condition_id}')]//android.widget.ToggleButton[@text='#{filter_value}']")
                      .with_wait(:clickable)
                      .build
    @mobile_actions.click(filter_criteria_button)
    @mobile_actions.click(filter_value_button)
  end

  def filter_by_location(filter_value)
    location_id = 'Envíos'
    filter_criteria_button = MobileElementBuilder.new
                      .with_type(:accessibility_id)
                      .with_value(location_id)
                      .with_wait(:clickable)
                      .build
    filter_value_button = MobileElementBuilder.new
                      .with_type(:xpath)
                      .with_value("//android.view.View[contains(@resource-id, 'component-#{location_id}')]//android.widget.ToggleButton[@text='#{filter_value}']")
                      .with_wait(:clickable)
                      .build
    @mobile_actions.click(filter_criteria_button)
    @mobile_actions.click(filter_value_button)
  end

  def filter_by_order(filter_value)
    order_id_one = 'Ordenar por '
    order_id_two = 'Ordenar por'
    filter_criteria_button = MobileElementBuilder.new
                      .with_type(:accessibility_id)
                      .with_value(order_id_one)
                      .with_wait(:clickable)
                      .build
    filter_value_button = MobileElementBuilder.new
                      .with_type(:xpath)
                      .with_value("//android.view.View[contains(@resource-id, 'component-#{order_id_two}')]//android.widget.ToggleButton[@text='#{filter_value}']")
                      .with_wait(:clickable)
                      .build
    @mobile_actions.click(filter_criteria_button)
    @mobile_actions.click(filter_value_button)
  end

  def swipe_on_filter_column(filter_value)
    filter_criteria_button = MobileElementBuilder.new
                      .with_type(:accessibility_id)
                      .with_value(filter_value)
                      .build
    @mobile_actions.scroll_until_visible_on_element(@filter_column, filter_criteria_button)
  end

  def click_on_see_results()
    @mobile_actions.click(@see_results_button)
  end

  def get_five_firsts_products_pricces()
    actualProductNames = @mobile_actions.scroll_until_list_has_size_and_return_texts(@search_results_body, @first_five_product_names, 5)
    actualProductPricesString = clean_prices(@mobile_actions.scroll_until_list_has_size_and_return_texts(@search_results_body, @first_five_product_prices, 5))
    actualProductPrices = actualProductPricesString.map(&:to_i)
    actualProductNames.zip(actualProductPrices).each do |name, price|
        puts "#{name} - #{price}"
    end
    actualProductPrices
  end

  def clean_prices(raw_array)
  raw_array.map do |price|
    price.gsub(/[^\d.,]/, '')
         .gsub(',', '')    
  end
end

end