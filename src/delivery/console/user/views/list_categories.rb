module Delivery::Console::User
  module Views
    class ListCategories
      def show(view_object)
        categories = view_object[:categories]

        system "clear"
        Array(categories).each_with_index do |cat, index|
          puts "#{index + 1}. #{cat}"
        end
      end
    end
  end
end
