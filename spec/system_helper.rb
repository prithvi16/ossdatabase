# Load general RSpec Rails configuration
require "rails_helper.rb"

# Load configuration files and helpers
Dir[File.join(__dir__, "system/support/**/*.rb")].sort.each { |file| require file }
