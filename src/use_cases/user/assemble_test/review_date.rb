module UseCases::User
  module AssembleTest
    class ReviewDate
      def initialize(review_history)
        collection        = Array(review_history)
        sorted_collection = collection.sort_by { |e| e[:date] }

        @review_history   = sorted_collection
      end

      def value
        return Date.today if review_history.empty? || failed_last_time?

        delta  = successful_reviews.last[:date] - successful_reviews.first[:date]
        offset = case delta
                 when 0 then 1
                 when 0..1 then 2
                 when 0..3 then 3
                 when 0..6 then 7
                 when 0..13 then 14
                 else 30
                 end

        successful_reviews.first[:date] + delta + offset
      end

      private

      attr_reader :review_history

      def failed_last_time?
        !review_history.last[:success]
      end

      def successful_reviews
        @successful_reviews ||= fetch_successful_reviews
      end

      def fetch_successful_reviews
        review_history.reverse.take_while { |e| e[:success] }.reverse
      end

      def rec_fetch_successful_reviews
        i = last_failure_index(review_history.length - 1)

        review_history[i..]
      end

      # Assumptions:
      #   * collection is not empty
      #   * there is at least one "success" in front of the collection
      def last_failure_index(i)
        return i if i == 0
        return i + 1 if not review_history[i][:success]

        last_failure_index(i - 1)
      end
    end
  end
end
