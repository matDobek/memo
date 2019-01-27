module UseCases::User
  module AssembleTest
    class UseCase
      def initialize(memos_gateway:, categories_gateway:)
        @memos_gateway = memos_gateway
        @categories_gateway = categories_gateway
      end

      def execute(presenter:, category_id:)
        category_id    = category_id.to_i
        category_name  = categories_gateway
          .find_by_id(category_id)
          &.name

        filtered_memos = memos_gateway.all.filter do |memo|
          match_selected_category = memo.category_id == category_id
          time_to_review          = true

          match_selected_category && time_to_review
        end

        filtered_memos.each_with_object([]) do |memo, collection|
          collection << presenter.present(memo, category_name)
        end
      end

      private

      attr_reader :memos_gateway, :categories_gateway
    end
  end
end
