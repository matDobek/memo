describe DataInterfaces::Memory::Gateways::Category do
  let(:invalid_hash) do
    {
      name: ""
    }
  end

  let(:valid_hash) do
    {
      name: "ScIeNcE"
    }
  end

  let(:valid_hash_1) do
    {
      name: "Math"
    }
  end

  describe "#valid?" do
    context "when name is empty" do
      it "returns false" do
        valid_hash[:name] = ""

        results = subject.valid?(valid_hash)

        expect(results).to eq(false)
      end
    end

    context "when name already exists" do
      it "returns false" do
        subject.add(valid_hash)

        valid_hash[:name] = "SCIENCE"
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
      it "adds element to repository" do
        subject.add(valid_hash)

        result = subject.all.first

        expect(result.id).to eq(1)
        expect(result.name).to eq("science")
      end

      it "returns Category entity with proper ID" do
        result = subject.add(valid_hash)

        expect(result.id).to eq(1)
        expect(result.name).to eq("science")
      end
    end

    context "when invalid" do
      it "returns Category entity without ID" do
        result = subject.add(invalid_hash)

        expect(result.id).to eq(nil)
        expect(result.name).to eq("")
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

  describe "#find_by_name" do
    it "returns entity with given name" do
      subject.add(valid_hash)
      subject.add(valid_hash_1)

      result = subject.find_by_name("SCIENCE")
      expect(result.name).to eq("science")
    end

    it "returns nil if nothing found" do
      subject.add(valid_hash)
      subject.add(valid_hash_1)

      result = subject.find_by_name("non_existing_category")
      expect(result).to eq(nil)
    end
  end

  describe "#find_by_id" do
    it "returns entity with given id" do
      subject.add(valid_hash)
      subject.add(valid_hash_1)

      result = subject.find_by_id(1)
      expect(result.id).to eq(1)
    end

    it "returns nil if nothing found" do
      subject.add(valid_hash)
      subject.add(valid_hash_1)

      result = subject.find_by_id(-1)
      expect(result).to eq(nil)
    end
  end
end
