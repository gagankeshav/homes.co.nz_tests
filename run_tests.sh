echo "Installing dependencies..."

# Install all the gems needs to execute the tests
gem install selenium-webdriver --no-document
gem install rspec --no-document
gem install rest-client --no-document
gem install yaml --no-document
gem install webdrivers --no-document

# Navigate to the tests directory
cd tests

# Execute the tests based on the input parameters provided
echo "Running Tests..."
if [ -z "$1" ]
then
      rspec tests_spec.rb --format documentation
else
      URL=$1 rspec tests_spec.rb --format documentation
fi