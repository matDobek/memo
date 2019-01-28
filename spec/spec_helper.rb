require "./src/loader"

Dir["./spec/support/**/*.rb"].each { |f| require f }

require "timecop"

RSpec.configure do |config|
  config.before(:each) do
    DataInterfaces::Memory::Repository::Memo.clear!
    DataInterfaces::Memory::Repository::Category.clear!
  end
end
