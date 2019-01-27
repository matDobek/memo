module Delivery::Console::User
  module Presenters
    class Categories
      def present(categories)
        formatted_categories = categories.map do |category|
          category.split.map(&:capitalize).join(" ")
        end

        {
          categories: formatted_categories
        }
      end
    end
  end
end
