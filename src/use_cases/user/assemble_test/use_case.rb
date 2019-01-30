module UseCases::User
  module AssembleTest
    class UseCase
      def initialize(memos_gateway:, categories_gateway:, reviews_gateway:)
        @memos_gateway      = memos_gateway
        @categories_gateway = categories_gateway
        @reviews_gateway    = reviews_gateway
      end

      def execute(presenter:, category_id:)
        reviews       = reviews_gateway.all
        category_id   = category_id.to_i
        category_name = categories_gateway.find_by_id(category_id)&.name

        filtered_memos = memos_gateway.all.filter do |memo|
          next if memo.category_id != category_id

          memo_review_history     = reviews.filter { |e| e.memo_id == memo.id }.map(&:to_h)
          suggested_review_date   = ReviewDate.new(memo_review_history).value

          suggested_review_date <= Date.today
        end

        filtered_memos.each_with_object([]) do |memo, collection|
          collection << presenter.present(memo, category_name)
        end
      end

      private

      attr_reader :memos_gateway, :categories_gateway, :reviews_gateway

      def reviews
        @reviews ||= reviews_gateway.all
      end
    end
  end
end
