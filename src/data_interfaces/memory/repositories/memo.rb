module DataInterfaces::Memory
  module Repository
    class Memo
      @@collection = []

      class << self
        def all
          @@collection
        end

        def add(elem)
          elem.id = Digest::MD5.hexdigest(elem.question)

          @@collection << elem

          elem
        end

        def clear!
          @@collection = []
        end
      end
    end
  end
end
