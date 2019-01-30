module UseCases
  class Factory
    class << self
      def save_results
        UseCases::User::SaveTestResults::UseCase.new(
          reviews_gateway: reviews_gateway,
        )
      end

      def assemble_test
        UseCases::User::AssembleTest::UseCase.new(
          memos_gateway: memos_gateway,
          categories_gateway: categories_gateway,
          reviews_gateway: reviews_gateway,
        )
      end

      private

      def memos_gateway
        DataInterfaces::Memory::Gateways::Memo.new
      end

      def categories_gateway
        DataInterfaces::Memory::Gateways::Category.new
      end

      def reviews_gateway
        DataInterfaces::File::Gateways::Review.new("./data/review_repository")
      end
    end
  end
end
