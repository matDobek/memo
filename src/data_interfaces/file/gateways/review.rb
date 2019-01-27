module DataInterfaces::File
  module Gateways
    class Review
      def initialize(file_path)
        @file_path = file_path
      end

      def valid?(data)
        memo_id  = data[:memo_id]
        date     = data[:date]
        success  = data[:success]

        memo_id_present = !memo_id.nil?
        date_present    = !date.nil?
        success_present = !success.nil?

        memo_id_present && date_present && success_present
      end

      def add(data)
        review         = Entities::Review.new
        review.memo_id = data[:memo_id]
        review.date    = data[:date]
        review.success = data[:success]

        valid?(data) ? repository.add(review) : review
      end

      def all
        repository.all
      end

      private

      attr_reader :file_path

      def repository
        DataInterfaces::File::Repository::Review.new(file_path)
      end
    end
  end
end
