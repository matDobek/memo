describe UseCases::User::ListCategories::UseCase do
  include_context "dir_with_memos, gateways, load_sample_memos"

  let(:categories_gateway) do
    DataInterfaces::Memory::Gateways::Category.new
  end

  subject do
    described_class.new(categories_gateway: categories_gateway)
  end

  it "returns proper view data" do
    load_sample_memos

    presenter = Delivery::Console::User::Presenters::Categories.new
    result = subject.execute(presenter: presenter)

    expect(result).to eq({
      categories: ["Sample Science", "Empty Category", "Sample Mathematics"]
    })
  end
end

