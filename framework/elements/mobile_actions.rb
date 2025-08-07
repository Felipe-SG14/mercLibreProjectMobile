require 'appium_lib'

class MobileActions

  def initialize(driver)
    @driver = driver
  end

  def wait_element(mobile_element)
    wait = Selenium::WebDriver::Wait.new(timeout: mobile_element.timeout)
    wait.until do
      begin
        element = @driver.find_element(mobile_element.locator_type, mobile_element.locator_value)
        case mobile_element.wait_condition
        when :visible
          element.displayed?
        when :present
          true
        when :clickable
          element.displayed? && element.enabled?
        when :invisible
          !element.displayed?
        when :not_present
          false
        else
          raise "Condition not supported: #{mobile_element.wait_condition}"
        end

        element
      rescue Selenium::WebDriver::Error::NoSuchElementError
        if mobile_element.wait_condition == :not_present
          true
        else
          raise
        end
      end
    end
  end

  def click(mobile_element)
    sleep 0.5
    wait_element(mobile_element).click
  end

  def send_keys(mobile_element, text)
    wait_element(mobile_element).send_keys(text)
  end

  def clear(mobile_element)
    wait_element(mobile_element).clear
  end

  def scroll_until_visible_on_element(scroll_container, mobile_element, direction: 'down', max_scrolls: 10, distance: 500)
    max_scrolls.times do |i|
    begin
        element = @driver.find_element(mobile_element.locator_type, mobile_element.locator_value)
        return element if element.displayed?
      rescue Selenium::WebDriver::Error::NoSuchElementError
      end
      scroll_on_element(scroll_container, direction: direction, distance: distance)
    end
    raise "Element not found #{target_locator} after #{max_scrolls} scrolls"
  end

  def scroll_on_element(mobile_element, direction: 'down', percent: 0.8, distance: 500, padding: 30)
    element = wait_element(mobile_element)
    rect = element.rect
    left = rect[:x] + padding
    top = rect[:y] + padding
    width = rect[:width] - 2 * padding
    height = rect[:height] - 2 * padding

    size = (direction == 'up' || direction == 'down') ? height : width
    percent = [distance.to_f / size, 1.0].min

    @driver.execute_script('mobile: scrollGesture', {
      left: left,
      top: top,
      width: width,
      height: height,
      direction: direction,
      percent: percent
    })
  end

  def scroll_until_list_has_size_and_return_texts(container, mobile_element, expected_size, direction: 'down', max_scrolls: 15, distance: 100)
    texts = []
    max_scrolls.times do |i|
      elements = @driver.find_elements(mobile_element.locator_type ,mobile_element.locator_value)
      texts = elements.map(&:text).reject(&:empty?)
      return texts if texts.size >= expected_size
      scroll_on_element(container, direction: direction, distance: distance, padding:400)
    end
    raise "Expected at least #{expected_size} elements with text, but only found #{texts.size} after #{max_scrolls} scrolls."
  end
end