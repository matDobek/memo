module UseCases::User
  module SaveTestResults
    class UseCase
      def initialize(reviews_gateway:)
        @reviews_gateway = reviews_gateway
      end

      def execute(results:)
        current_date = Date.today

        results.each do |result|
          reviews_gateway.add({
            memo_id: result[:id],
            date: current_date,
            success: result[:success],
          })
        end
      end

      private

      attr_reader :reviews_gateway
    end
  end
end
