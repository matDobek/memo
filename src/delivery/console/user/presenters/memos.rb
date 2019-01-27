module Delivery::Console::User
  module Presenters
    class Memos
      def present(memo, category_name)
        formatted_category = category_name.split.map(&:capitalize).join(" ")

        {
          category: formatted_category,
          question: memo.question,
          answer: memo.answer,
        }
      end
    end
  end
end
