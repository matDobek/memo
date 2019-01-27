module UseCases::System
  module ImportDataFromDirectory
    class FileContentParser
      def initialize(content)
        @content = content
      end

      def parsed_collection
        collection = []
        categories = split_by(content, category_starter_regexp)

        categories.reject(&:empty?).each do |category_with_questions|
          category, _, questions = category_with_questions.partition("\n")
          questions              = split_by(questions, question_starter_regexp)

          questions.reject(&:empty?).each do |question_with_answer|
            question, _, answer = question_with_answer.partition("\n")

            collection << {
              category: category.strip,
              question: question.strip,
              answer: answer.strip,
            }
          end
        end

        collection
      end

      private

      attr_reader :content

      def category_starter_regexp
        %r{\n+# }
      end

      def question_starter_regexp
        %r{\n+## }
      end

      def split_by(content, regexp)
        content
          .prepend("\n")    # make sure that first elem matches regexp
          .split(regexp)
      end
    end
  end
end
