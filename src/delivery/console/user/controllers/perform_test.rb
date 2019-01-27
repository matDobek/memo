module Delivery::Console::User
  module Controllers
    class PerformTest
      def execute(selected_category)
        memos_gateway      = DataInterfaces::Memory::Gateways::Memo.new
        categories_gateway = DataInterfaces::Memory::Gateways::Category.new
        presenter          = Delivery::Console::User::Presenters::Memos.new
        view               = Delivery::Console::User::Views::ListMemos.new
        view_object        = UseCases::User::AssembleTest::UseCase
          .new(memos_gateway: memos_gateway, categories_gateway: categories_gateway)
          .execute(category_id: selected_category, presenter: presenter)

        view.show(view_object)
      end
    end
  end
end
