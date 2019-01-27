module Delivery::Console::User
  module Controllers
    class ImportData
      def execute(directory)
        memos_gateway      = DataInterfaces::Memory::Gateways::Memo.new
        categories_gateway = DataInterfaces::Memory::Gateways::Category.new

        UseCases::System::ImportDataFromDirectory::UseCase
          .new(memos_gateway: memos_gateway, categories_gateway: categories_gateway)
          .execute(directory: directory)
      end
    end
  end
end
