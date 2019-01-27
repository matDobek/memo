require "./src/loader"

memo_location_dir = ARGV[0]

ARGV.clear

import_data     = Delivery::Console::User::Controllers::ImportData.new
list_categories = Delivery::Console::User::Controllers::ListCategories.new
perform_test    = Delivery::Console::User::Controllers::PerformTest.new

import_data.execute(memo_location_dir)

loop do
  list_categories.execute
  selected_category = gets.chomp
  perform_test.execute(selected_category)
end
