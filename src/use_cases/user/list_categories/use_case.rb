module UseCases::User
  module ListCategories
    class UseCase
      def initialize(categories_gateway:)
        @categories_gateway = categories_gateway
      end

      def execute(presenter:)
        categories = categories_gateway.all.map(&:name)
        presenter.present(categories)
      end

      private

      attr_reader :categories_gateway
    end
  end
end
