module Delivery::Console::User
  module Views
    class ListMemos
      def show(view_object)
        view_object.each do |memo|
          system "clear"

          puts memo[:category]
          puts memo[:question]
          puts "===================="
          gets
          puts memo[:answer]
          gets
        end
      end
    end
  end
end
