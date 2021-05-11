# Initial configuration
$LOAD_PATH.unshift File.expand_path('../../', __FILE__)
require 'helpers'

RSpec.describe "homes.co.nz Tests" do

  # Loading the configuration from config.yml file
  $config = YAML.load_file(File.expand_path('../../config/config.yml', __FILE__))

  # Select the environment(s) on which the tests need to be executed
  if ENV["URL"] == nil
    env = %w[staging prod]
  else
    env = [ENV["URL"]]
  end

  # Iterate over the array outlining the environment(s) that the tests need to be executed upon
  env.each do |environment|
    # Proceed with functional tests only if the application is available
    context "API Test" do
      it "DOA test to validate that #{environment} website is up" do
        response = RestClient.get($config[environment])
        expect(response.code).to eq(200)
      end
    end

    context "UI tests" do

      before(:all) do
        # Instantiating webdriver instance for chrome browser
        @driver = Selenium::WebDriver.for :chrome

        # Maximizing the browser window
        @driver.manage.window.maximize
      end

      before(:each) do
        # Opening the Web Application
        @driver.get($config[environment])

        # Instantiating the Page objects for the Web Application Page libraries
        @home_page = HomePage.new(@driver)
        @results_page = Results.new(@driver)
      end

      it "Validate that user is able to search for Auckland" do
        @home_page.search_for_location('Auckland')

        # Partial match using include is used since search string in the Web Page keeps changing
        expect(@driver.current_url).to include($config["#{environment}_akl_search_url"])
      end

      it "Validate that user is able to search for Petone" do
        @home_page.search_for_location('Petone')

        # Partial match using include is used since search string in the Web Page keeps changing
        expect(@driver.current_url).to include($config["#{environment}_pet_search_url"])
      end

      it "Validate that user is able to search specific addresses" do
        @home_page.search_for_location('45 Puru Crescent')

        aggregate_failures do
          # Partial match using include is used since search string in the Web Page keeps changing
          expect(@driver.current_url).to include($config["#{environment}_custom_search_url"])
          expect(@results_page.get_result_list[0]).to eq($config["puru_address"])
        end
      end

      after(:all) do
        # Close the browser instance
        @driver.quit
      end
    end
  end
end
