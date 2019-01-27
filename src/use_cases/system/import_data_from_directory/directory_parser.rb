module UseCases::System
  module ImportDataFromDirectory
    class DirectoryParser
      def initialize(directory)
        @directory = directory
      end

      def parsed_collection
        return [] if invalid_directory?

        collection = []

        file_paths.each do |rel_path|
          file_content = File.read "#{directory}/#{rel_path}"

          collection << FileContentParser.new(file_content).parsed_collection
        end

        collection.flatten
      end

      private

      attr_reader :directory

      def invalid_directory?
        directory.nil? || !Dir.exists?(directory)
      end

      def file_paths
        Dir.children(directory)
      end
    end
  end
end
