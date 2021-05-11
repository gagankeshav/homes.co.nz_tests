class Results
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 60)
  end

  # UI Elements in the format of how and what as expected by Selenium
  ELEMENTS = {'result_list' => [:xpath, "//h2[contains(@class, 'address')]"]}

  # Method to get a list of the search results from the Search Results Page
  def get_result_list
    result_list = []
    @wait.until { wait_for_element("result_list").length > 10 }
    find_elements("result_list").each do |result|
      result_list.push(result.text)
    end
    result_list
  end

  # Custom methods to handle dynamic waits
  def wait_for_element(element)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { find_elements(element) }
  end

  def find_elements(elements)
    @driver.find_elements(ELEMENTS[elements][0], ELEMENTS[elements][1])
  end
end