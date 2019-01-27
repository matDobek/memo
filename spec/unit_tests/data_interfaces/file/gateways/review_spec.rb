describe DataInterfaces::File::Gateways::Review do
  include_context "review_repository_file_path"
  include_context "tmp_review_repository_file_path, clear_tmp_review_repository!"

  let(:valid_hash) do
    {
      memo_id: 1,
      date: Date.new(1999, 01, 01),
      success: false,
    }
  end

  let(:valid_hash_1) do
    {
      memo_id: 2,
      date: Date.new(1999, 01, 02),
      success: true,
    }
  end

  subject do
    described_class.new(review_repository_file_path)
  end

  describe "#valid?" do
    context "when memo_id is nil" do
      it "returns false" do
        valid_hash[:memo_id] = nil

        results = subject.valid?(valid_hash)

        expect(results).to eq(false)
      end
    end

    context "when date is nil" do
      it "returns false" do
        valid_hash[:date] = nil
        results = subject.valid?(valid_hash)

        expect(results).to eq(false)
      end
    end

    context "when success is nil" do
      it "returns false" do
        valid_hash[:success] = nil
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
    before do
      clear_tmp_review_repository!
    end

    after do
      clear_tmp_review_repository! # make sure .git repo is not altered
    end

    let(:tmp_repository) do
      described_class.new(tmp_review_repository_file_path)
    end

    context "when valid" do
      it "does not wipe previous entries" do
        tmp_repository.add(valid_hash)
        tmp_repository.add(valid_hash)

        result = tmp_repository.all.count

        expect(result).to eq(2)
      end

      it "adds element to the repository" do
        tmp_repository.add(valid_hash)

        result = tmp_repository.all.last

        expect(result.memo_id).to eq("1")
        expect(result.date).to eq(Date.new(1999, 01, 01))
        expect(result.success).to eq(false)
      end
    end

    context "when invalid" do
      it "does not add element to the repository" do
        valid_hash[:date] = nil
        tmp_repository.add(valid_hash)

        result = tmp_repository.all.count

        expect(result).to eq(0)
      end
    end
  end

  describe "#all" do
    it "returns all entities" do
      result = subject.all.map(&:to_h)

      expect(result).to include({
        memo_id: "1",
        date: Date.new(2019, 01, 01),
        success: true,
      })

      expect(result).to include({
        memo_id: "2",
        date: Date.new(2019, 01, 01),
        success: false,
      })

      expect(result).to include({
        memo_id: "1",
        date: Date.new(2019, 01, 02),
        success: true,
      })
    end
  end
end
