module Delivery::Console::User
  module Controllers
    class ListCategories
      def execute
        categories_gateway = DataInterfaces::Memory::Gateways::Category.new
        presenter          = Delivery::Console::User::Presenters::Categories.new
        view               = Delivery::Console::User::Views::ListCategories.new
        view_object        = UseCases::User::ListCategories::UseCase
          .new(categories_gateway: categories_gateway)
          .execute(presenter: presenter)

        view.show(view_object)
      end
    end
  end
end
