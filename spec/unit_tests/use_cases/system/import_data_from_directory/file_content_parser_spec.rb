describe UseCases::System::ImportDataFromDirectory::FileContentParser do
  subject do
    described_class.new(<<~CONTENT)
      # Math
      ## 1 + 1?

      2.

      # Science
      ## In which categories Nobel prize can be awarded?
      Physics
      Chemistry
      Economics
      Physiology or Medicine
      Prize in Peace

      ## Year of the first Nobel prize ceremony?
      1901
    CONTENT
  end

  describe "#parsed_collection" do
    it "properly parse the content" do
      result = subject.parsed_collection

      expect(result).to include({
        category: "Math",
        question: "1 + 1?",
        answer: "2.",
      })

      expect(result).to include({
        category: "Science",
        question: "In which categories Nobel prize can be awarded?",
        answer: "Physics\nChemistry\nEconomics\nPhysiology or Medicine\nPrize in Peace",
      })

      expect(result).to include({
        category: "Science",
        question: "Year of the first Nobel prize ceremony?",
        answer: "1901",
      })
    end
  end
end

