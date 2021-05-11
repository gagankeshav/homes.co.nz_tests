
# homes.co.nz-tests
Repo for Automated Tests for the homes.co.nz production and staging Website

# Pre-requisites:
Ruby should be installed on the system.  
[Direct Download Link for Windows](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.0.0-1/rubyinstaller-devkit-3.0.0-1-x64.exe)  
[Installation instructions for MacOS](https://www.ruby-lang.org/en/documentation/installation/#homebrew)

# Executing the tests
Download the tests on local system, either as a zip file or clone them using Git.   
Using either *Git Bash/Command Prompt/Powershell*, navigate to the *root* folder within the repo. on your local system and execute below command to execute the tests:
- For execution on staging environment
   - sh test_specs.sh staging
- For execution on production environment
   - sh test_specs.sh prod
- No parameter executes on both the environments sequentially
   - sh test_specs.sh