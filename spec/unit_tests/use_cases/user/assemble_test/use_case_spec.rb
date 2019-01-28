describe UseCases::User::AssembleTest::UseCase do
  include_context "dir_with_memos, gateways, load_sample_memos"

  subject do
    described_class.new(
      memos_gateway: memos_gateway,
      categories_gateway: categories_gateway,
    )
  end

  it "assembles test with categories, questions, and answers" do
    load_sample_memos

    presenter = Delivery::Console::User::Presenters::Memos.new

    result = subject
      .execute(category_id: 1, presenter: presenter)
      .map(&:to_h)

    expect(result).to include({
      id: "06b15aaa2046df47294d7bf1cad9a0d2",
      category: "Sample Science",
      question: "Question 1",
      answer: "Answer 1.",
    })

    expect(result).to include({
      id: "21c58e47a1a80e754148cc396bc8794d",
      category: "Sample Science",
      question: "Question 2",
      answer: "Answer 2.\nAnswer 2.",
    })
  end
end

