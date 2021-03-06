require "date"
require "digest"
require "io/console"

Dir[
  "./src/**/_module_init.rb",
  "./src/use_cases/**/*.rb",
  "./src/entities/**/*.rb",
  "./src/data_interfaces/**/*.rb",
  "./src/delivery/**/*.rb",
].each { |f| require f }
