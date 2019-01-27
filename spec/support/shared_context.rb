shared_context "dir_with_memos" do
  let(:dir_with_memos) do
    "#{File.dirname(__FILE__)}/../fixtures/dir_with_memos"
  end
end

shared_context "gateways" do
  let(:memos_gateway)  do
    DataInterfaces::Memory::Gateways::Memo.new
  end

  let(:categories_gateway)  do
    DataInterfaces::Memory::Gateways::Category.new
  end
end

shared_context "dir_with_memos, gateways, load_sample_memos" do
  include_context "dir_with_memos"
  include_context "gateways"

  let(:load_sample_memos) do
    UseCases::System::ImportDataFromDirectory::UseCase
      .new(
        memos_gateway: memos_gateway,
        categories_gateway: categories_gateway,
      )
      .execute(directory: dir_with_memos)
  end
end
