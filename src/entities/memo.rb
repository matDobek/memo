module Entities
  class Memo
    attr_accessor :question, :answer, :id, :category_id

    def to_h
      {
        id: id,
        category_id: category_id,
        question: question,
        answer: answer,
      }
    end
  end
end
