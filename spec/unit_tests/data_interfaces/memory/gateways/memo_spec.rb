describe DataInterfaces::Memory::Gateways::Memo do
  let(:valid_hash) do
    {
      category_id: 1,
      question: "1 + 1?",
      answer: "2",
    }
  end

  let(:valid_hash_1) do
    {
      category_id: 2,
      question: "The meaning of life, universe, and everything?",
      answer: "42",
    }
  end

  describe "#valid?" do
    context "when category_id is nil" do
      it "returns false" do
        valid_hash[:category_id] = nil

        results = subject.valid?(valid_hash)

        expect(results).to eq(false)
      end
    end

    context "when question is empty" do
      it "returns false" do
        subject.add(valid_hash)

        valid_hash[:question] = ""
        results = subject.valid?(valid_hash)

        expect(results).to eq(false)
      end
    end

    context "when answer is empty" do
      it "returns false" do
        subject.add(valid_hash)

        valid_hash[:answer] = ""
        results = subject.valid?(valid_hash)

        expect(results).to eq(false)
      end
    end

    context "when valid" do
      it "returns true" do
        results = subject.valid?(valid_hash)

        expect(results).to eq(true)
      end
    end
  end

  describe "#add" do
    context "when valid" do
      it "adds element to the repository" do
        subject.add(valid_hash)

        result = subject.all.first

        expect(result.category_id).to eq(1)
        expect(result.question).to eq("1 + 1?")
        expect(result.answer).to eq("2")
      end

      it "returns Memo entity with proper ID" do
        result = subject.add(valid_hash)

        expect(result.id).to eq("8f7aa636171798a9b41c8935ef3c0096")
      end
    end

    context "when invalid" do
      it "returns Category entity without ID" do
        valid_hash[:question] = ""

        result = subject.add(valid_hash)

        expect(result.id).to eq(nil)
      end
    end
  end

  describe "#all" do
    it "returns all entities" do
      subject.add(valid_hash)
      subject.add(valid_hash_1)

      result = subject.all.count
      expect(result).to eq(2)
    end
  end
end

