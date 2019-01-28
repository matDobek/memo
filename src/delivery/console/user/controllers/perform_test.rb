module Delivery::Console::User
  module Controllers
    class PerformTest
      def execute(selected_category)
        save_results_use_case  = UseCases::Factory.save_results
        assemble_test_use_case = UseCases::Factory.assemble_test
        memo_presenter         = Delivery::Console::User::Presenters::Memos.new
        memo_view              = Delivery::Console::User::Views::ListMemo.new
        memo_with_ans_view     = Delivery::Console::User::Views::ListMemoWithAnswer.new
        view_objects           = assemble_test_use_case.execute(category_id: selected_category, presenter: memo_presenter)

        results = []

        view_objects.each_with_index do |view_object, index|
          memo_view.show(view_object)
          collect_user_response
          memo_with_ans_view.show(view_object)

          results << {
            id: view_object[:id],
            success: collect_user_response == :success,
          }
        end

        save_results_use_case.execute(results: results)
      end

      private

      def collect_user_response
        while key = STDIN.getch
          return :success if key == "j"
          return :failure if key == "k"
        end
      end
    end
  end
end
