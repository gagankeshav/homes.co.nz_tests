class HomePage

  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 60)
  end

  # UI Elements in the format of how and what as expected by Selenium
  ELEMENTS = {'search_field' => [:id, "autocomplete-search"],
              'search_button' => [:xpath, "//button[contains(@class, 'homes-button-main')]"],
              'search_results' => [:xpath, "//*[contains(@class, 'addressResultStreet') and text() = '__search_string__ ']"],
              'map_zoom_control' => [:xpath, "//button[contains(@class, 'typeSatellite')]"]}

  # Method to enter the search criteria in the search field
  def enter_search_location(location_name)
    wait_for_element('search_field').send_keys location_name
  end

  # Method to select the search result from the list of results
  def select_search_string(location_name)
    wait_for_element('search_results', location_name).click
  end

  # Compound method to perform search on the Home Page
  def search_for_location(location_name)
    enter_search_location(location_name)
    select_search_string(location_name)

    # Below code helps to ensure that user is on the
    # search results page and the page has loaded correctly
    el = wait_for_element('map_zoom_control')
    @driver.action.move_to(el).perform
  end

  # Custom methods to handle dynamic waits
  def wait_for_element(element, custom=nil)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    if custom
      wait.until { find_element(element, custom) }
    else
      wait.until { find_element(element) }
    end
  end

  def find_element(element, custom = nil)
    if custom
      ele = ELEMENTS[element][1].gsub(/__search_string__/, custom)
      @driver.find_element(ELEMENTS[element][0], ele)
    else
      @driver.find_element(ELEMENTS[element][0], ELEMENTS[element][1])
    end
  end
end