module Delivery::Console::User
  module Views
    class ListMemo
      def show(view_object)
        system "clear"

        puts view_object[:category]
        puts view_object[:question]
        puts "===================="
      end
    end
  end
end
