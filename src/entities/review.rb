module Entities
  class Review
    attr_accessor :memo_id, :date, :success

    def to_h
      {
        memo_id: memo_id,
        date: date,
        success: success,
      }
    end
  end
end
