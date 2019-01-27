module UseCases::System
  module ImportDataFromDirectory
    class UseCase
      def initialize(memos_gateway:, categories_gateway:)
        @memos_gateway      = memos_gateway
        @categories_gateway = categories_gateway
      end

      def execute(directory:)
        memo_collection = DirectoryParser.new(directory).parsed_collection

        memo_collection.each do |memo|
          categories_gateway.add({
            name: memo[:category]
          })

          # TODO : This will be slow for most gateways ( except in-memory ones )
          category = categories_gateway.find_by_name(memo[:category])

          memos_gateway.add({
            category_id: category.id,
            question: memo[:question],
            answer: memo[:answer],
          })
        end
      end

      private

      attr_reader :memos_gateway, :categories_gateway
    end
  end
end
