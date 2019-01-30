describe UseCases::User::AssembleTest::UseCase do
  include_context "dir_with_memos, gateways, load_sample_memos"
  include_context "file gateways"

  subject do
    described_class.new(
      memos_gateway: memos_gateway,
      categories_gateway: categories_gateway,
      reviews_gateway: reviews_gateway,
    )
  end

  it "assembles test with categories, questions, and answers" do
    load_sample_memos

    presenter = Delivery::Console::User::Presenters::Memos.new

    Timecop.freeze(Date.new(1999, 1, 3)) do
      result = subject
        .execute(category_id: "1", presenter: presenter)
        .map(&:to_h)

      expect(result).to eq([{
        id: "21c58e47a1a80e754148cc396bc8794d",
        category: "Sample Science",
        question: "Question 2",
        answer: "Answer 2.\nAnswer 2.",
      }])
    end
  end
end

