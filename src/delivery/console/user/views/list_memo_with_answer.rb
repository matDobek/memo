module Delivery::Console::User
  module Views
    class ListMemoWithAnswer
      def show(view_object)
        system "clear"

        puts view_object[:category]
        puts view_object[:question]
        puts "===================="
        puts
        puts view_object[:answer]
      end
    end
  end
end
