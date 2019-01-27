describe UseCases::System::ImportDataFromDirectory::DirectoryParser do
  include_context "dir_with_memos"

  subject do
    described_class.new(dir_with_memos)
  end

  describe "#parsed_collection" do
    context "when directory is nil" do
      it "returns empty array" do
        result = described_class.new(nil).parsed_collection

        expect(result).to eq([])
      end
    end

    context "when directory invalid" do
      it "returns empty array" do
        result = described_class.new("./invalid").parsed_collection

        expect(result).to eq([])
      end
    end

    context "when directory valid" do
      it "populates given repository with memos loaded from file repository" do
        result = subject.parsed_collection

        expect(result).to include({
          category: "Sample Science",
          question: "Question 1",
          answer: "Answer 1.",
        })

        expect(result).to include({
          category: "Sample Science",
          question: "Question 2",
          answer: "Answer 2.\nAnswer 2.",
        })

        expect(result).to include({
          category: "Sample Mathematics",
          question: "Question 3",
          answer: "Answer 3.\nAnswer 3.\n\nAnswer 3.",
        })

        expect(result).to include({
          category: "Sample Mathematics",
          question: "Question 4",
          answer: "Answer 4.\nAnswer 4.\n\nAnswer 4.\nAnswer 4.",
        })
      end
    end
  end
end
