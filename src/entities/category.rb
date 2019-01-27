module Entities
  class Category
    attr_accessor :id, :name

    def to_h
      {
        id: id,
        name: name,
      }
    end
  end
end
