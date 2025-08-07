class MobileElementBuilder
  def initialize
    @locator_type = nil
    @locator_value = nil
    @wait_condition = :visible
    @timeout = 10
  end

  def with_type(type)
    @locator_type = type
    self
  end

  def with_value(value)
    @locator_value = value
    self
  end

  def with_wait(condition)
    @wait_condition = condition
    self
  end

  def with_timeout(seconds)
    @timeout = seconds
    self
  end

  def build
    raise 'locator_type is missing' unless @locator_type
    raise 'locator_value is missing' unless @locator_value

    MobileElement.new(
      locator_type: @locator_type,
      locator_value: @locator_value,
      wait_condition: @wait_condition,
      timeout: @timeout
    )
  end
end