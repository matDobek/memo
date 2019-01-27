describe UseCases::System::ImportDataFromDirectory::UseCase do
  include_context "dir_with_memos"
  let(:memos_gateway) { DataInterfaces::Memory::Gateways::Memo.new }
  let(:categories_gateway) { DataInterfaces::Memory::Gateways::Category.new }

  subject do
    described_class.new(
      memos_gateway: memos_gateway,
      categories_gateway: categories_gateway
    )
  end

  describe "#execute" do
    it "populates category repository with data loaded from files" do
      subject.execute(directory: dir_with_memos)

      result = categories_gateway.all.map(&:name)

      expect(result).to eq([
        "sample science",
        "empty category",
        "sample mathematics",
      ])
    end

    it "populates memo repository with data loaded from files" do
      subject.execute(directory: dir_with_memos)

      result = memos_gateway.all.map do |memo|
        {
          category_id: memo.category_id,
          question: memo.question,
          answer: memo.answer,
        }
      end

      expect(result).to include({
        category_id: 1,
        question: "Question 1",
        answer: "Answer 1.",
      })

      expect(result).to include({
        category_id: 1,
        question: "Question 2",
        answer: "Answer 2.\nAnswer 2.",
      })

      expect(result).to include({
        category_id: 3,
        question: "Question 3",
        answer: "Answer 3.\nAnswer 3.\n\nAnswer 3.",
      })

      expect(result).to include({
        category_id: 3,
        question: "Question 4",
        answer: "Answer 4.\nAnswer 4.\n\nAnswer 4.\nAnswer 4.",
      })
    end
  end
end

