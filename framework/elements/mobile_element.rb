class MobileElement
  attr_reader :locator_type, :locator_value, :wait_condition, :timeout

  def initialize(locator_type:, locator_value:, wait_condition:, timeout:)
    @locator_type = locator_type
    @locator_value = locator_value
    @wait_condition = wait_condition
    @timeout = timeout
  end
end