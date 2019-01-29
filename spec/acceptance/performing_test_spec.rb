describe "Performing test" do
  include_context "dir_with_memos"
  include_context "file gateways"
  include_context "memory gateways"

  let(:import_data_use_case) do
    UseCases::System::ImportDataFromDirectory::UseCase
      .new(memos_gateway: memos_gateway, categories_gateway: categories_gateway)
  end

  let(:list_categories_use_case) do
    UseCases::User::ListCategories::UseCase
      .new(categories_gateway: categories_gateway)
  end

  let(:assemble_test_use_case) do
    UseCases::User::AssembleTest::UseCase
      .new(memos_gateway: memos_gateway, categories_gateway: categories_gateway, reviews_gateway: reviews_gateway)
  end

  let(:categories_presenter) do
    Delivery::Console::User::Presenters::Categories.new
  end

  let(:memos_presenter) do
    Delivery::Console::User::Presenters::Memos.new
  end

  it "performs test" do
    import_data_use_case.execute(directory: dir_with_memos)
    list_categories_use_case.execute(presenter: categories_presenter)
    assemble_test_use_case.execute(category_id: 1, presenter: memos_presenter)
  end
end
