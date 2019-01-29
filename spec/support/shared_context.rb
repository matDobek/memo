shared_context "review_repository_file_path" do
  let(:review_repository_file_path) do
    "#{File.dirname(__FILE__)}/../fixtures/file_repositories/review"
  end
end

shared_context "tmp_review_repository_file_path, clear_tmp_review_repository!" do
  let(:tmp_review_repository_file_path) do
    "#{File.dirname(__FILE__)}/../fixtures/file_repositories/tmp_review"
  end

  let(:clear_tmp_review_repository!) do
    File.truncate(tmp_review_repository_file_path, 0)
  end
end

shared_context "dir_with_memos" do
  let(:dir_with_memos) do
    "#{File.dirname(__FILE__)}/../fixtures/dir_with_memos"
  end
end

shared_context "file gateways" do
  include_context "review_repository_file_path"

  let(:reviews_gateway)  do
    DataInterfaces::File::Gateways::Review.new(review_repository_file_path)
  end
end

shared_context "memory gateways" do
  let(:memos_gateway)  do
    DataInterfaces::Memory::Gateways::Memo.new
  end

  let(:categories_gateway)  do
    DataInterfaces::Memory::Gateways::Category.new
  end
end

shared_context "dir_with_memos, gateways, load_sample_memos" do
  include_context "dir_with_memos"
  include_context "memory gateways"

  let(:load_sample_memos) do
    UseCases::System::ImportDataFromDirectory::UseCase
      .new(
        memos_gateway: memos_gateway,
        categories_gateway: categories_gateway,
      )
      .execute(directory: dir_with_memos)
  end
end
