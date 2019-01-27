module DataInterfaces::Memory
  module Gateways
    class Memo
      def valid?(memo_hash)
        category_id         = memo_hash[:category_id]
        question            = memo_hash[:question]
        answer              = memo_hash[:answer]

        category_id_present = !category_id.nil?
        question_present    = !String(question).empty?
        answer_present      = !String(answer).empty?

        category_id_present && question_present && answer_present
      end

      def add(memo_hash)
        memo             = Entities::Memo.new
        memo.question    = memo_hash[:question]
        memo.answer      = memo_hash[:answer]
        memo.category_id = memo_hash[:category_id]

        valid?(memo_hash) ? repository.add(memo) : memo
      end

      def all
        repository.all
      end

      private

      def repository
        DataInterfaces::Memory::Repository::Memo
      end
    end
  end
end
