require 'base64'
require 'fileutils'

class StepLogger
  Step = Struct.new(:name, :screenshot_path)

  def initialize
    @steps = []
    @screenshots_dir = 'screenshots'
    @report_path = 'logs/test_report.html'
    FileUtils.mkdir_p(@screenshots_dir)
    FileUtils.mkdir_p(File.dirname(@report_path))
    FileUtils.rm_rf(Dir.glob("#{@screenshots_dir}/*"))
  end

  def log_step(name, driver: nil)
    puts "🟢 Step: #{name}"
    yield if block_given?
    screenshot_path = take_screenshot(driver, name) if driver
    @steps << Step.new(name, screenshot_path)
  rescue => e
    puts "🔴 Error in step '#{name}': #{e.message}"
    raise
  end

  def generate_report
    puts "📄 Generating HTML report..."
    html = <<~HTML
      <html><head><title>Test Report</title></head><body><h1>Steps</h1>
    HTML

    @steps.each_with_index do |step, i|
      html += "<h2>#{i + 1}. #{step.name}</h2>"
      if step.screenshot_path && File.exist?(step.screenshot_path)
        img = Base64.encode64(File.binread(step.screenshot_path))
        html += "<img src='data:image/png;base64,#{img}' width='300' />"
      end
    end

    html += "</body></html>"
    File.write(@report_path, html)
    puts "✅ Report saved: #{@report_path}"
  end

  private

  def take_screenshot(driver, name)
    file = "#{@screenshots_dir}/#{sanitize_filename(name)}_#{Time.now.to_i}.png"
    driver.screenshot(file)
    file
  end

  def sanitize_filename(name)
    name.gsub(/\s+/, '_').gsub(/[^\w\-]/, '')
  end
end