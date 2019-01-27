module DataInterfaces::Memory
  module Repository
    class Category
      class << self
        @@collection = []
        @@id         = 0

        def all
          @@collection
        end

        def add(elem)
          elem.id = next_id

          @@collection << elem

          elem
        end

        def find_by_name(name)
          @@collection.find { |e| e.name == name }
        end

        def find_by_id(id)
          @@collection.find { |e| e.id == id }
        end

        def clear!
          @@collection = []
          @@id         = 0
        end

        private

        def next_id
          @@id += 1
        end
      end
    end
  end
end
