Dir[File.join(__dir__, '../../framework/elements', '*.rb')].each { |file| require_relative file }

class MercadoLibreCommonPage
  def initialize(actions)
    @mobile_actions = MobileActions.new(actions)
    @title_toolbar = MobileElementBuilder.new
                      .with_type(:id)
                      .with_value('com.mercadolibre:id/ui_components_toolbar_title_toolbar')
                      .build
    @search_input  = MobileElementBuilder.new
                      .with_type(:id)
                      .with_value('com.mercadolibre:id/autosuggest_input_search')
                      .build
  end

  def search(productName)
    @mobile_actions.click(@title_toolbar)
    @mobile_actions.send_keys(@search_input, productName)
    suggested_search = MobileElementBuilder.new
                      .with_type(:accessibility_id)
                      .with_value(productName)
                      .build
    @mobile_actions.click(suggested_search)
  end
end