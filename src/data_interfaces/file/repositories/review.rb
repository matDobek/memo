module DataInterfaces::File
  module Repository
    class Review
      def initialize(file_path)
        fail Errors::InvalidFile if !File.exists?(file_path)

        @file_path = file_path
      end

      def all
        collection = []

        File.read(file_path).each_line do |row|
          str_memo_id, str_date, str_success = row.split(",").map(&:strip)

          review = Entities::Review.new
          review.memo_id = str_memo_id
          review.date    = Date.parse(str_date)
          review.success = "true" == str_success.downcase

          collection << review
        end

        collection
      end

      def add(elem)
        File.open(file_path, "a") do |file|
          memo_id = elem.memo_id
          date    = elem.date.strftime("%Y-%m-%d")
          success = elem.success

          file << "#{memo_id}, #{date}, #{success}\n"
        end
      end

      private

      attr_reader :file_path
    end
  end
end
