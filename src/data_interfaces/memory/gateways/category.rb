module DataInterfaces::Memory
  module Gateways
    class Category
      def valid?(category_hash)
        name = String(category_hash[:name]).downcase

        name_is_present = !String(name).empty?
        name_is_uniq    = !all.map(&:name).include?(name)

        name_is_present && name_is_uniq
      end

      def add(category_hash)
        category = Entities::Category.new
        category.name = category_hash[:name].downcase

        valid?(category_hash) ? repository.add(category) : category
      end

      def all
        repository.all
      end

      def find_by_name(name)
        repository.find_by_name(name.downcase)
      end

      def find_by_id(id)
        repository.find_by_id( Integer(id) )
      end

      private

      def repository
        DataInterfaces::Memory::Repository::Category
      end
    end
  end
end
