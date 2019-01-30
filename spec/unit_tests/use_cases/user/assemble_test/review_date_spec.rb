describe UseCases::User::AssembleTest::ReviewDate do
  describe "#value" do
    context "when no review history" do
      it "returns current date" do
        review_history = []

        Timecop.freeze(Date.new(1999, 1, 1)) do
          result = described_class.new(review_history).value
          expect(result).to eq(Date.new(1999, 1, 1))
        end
      end
    end

    context "when failure is last element" do
      it "returns current date" do
        review_history = [
          { date: Date.new(1999, 1, 6), success: true },
          { date: Date.new(1999, 1, 7), success: true },
          { date: Date.new(1999, 1, 8), success: false },
        ]

        Timecop.freeze(Date.new(1999, 1, 10)) do
          result = described_class.new(review_history).value
          expect(result).to eq(Date.new(1999, 1, 10))
        end
      end
    end

    context "when review history is unsorted" do
      it "sorts the collection, returning proper result" do
        review_history = [
          { date: Date.new(1999, 1, 8), success: false },
          { date: Date.new(1999, 1, 7), success: true },
        ]

        Timecop.freeze(Date.new(1999, 1, 10)) do
          result = described_class.new(review_history).value
          expect(result).to eq(Date.new(1999, 1, 10))
        end
      end
    end

    context "when success is the last element" do
      context "when there is only one element" do
        it "returns review date + 1d" do
          review_history = [
            { date: Date.new(1999, 1, 1), success: true },
          ]

          result = described_class.new(review_history).value

          expect(result).to eq(Date.new(1999, 1, 2))
        end
      end

      context "when difference between the first success and the last is 0d" do
        it "returns first successful review date + 1d" do
          review_history = [
            { date: Date.new(1999, 1, 1), success: true },
            { date: Date.new(1999, 1, 1), success: true },
          ]

          result = described_class.new(review_history).value

          expect(result).to eq(Date.new(1999, 1, 2))
        end
      end

      context "when difference between the first success and the last is 1d" do
        it "returns first successful review date + 1d + 2d" do
          review_history = [
            { date: Date.new(1999, 1, 1), success: true },
            { date: Date.new(1999, 1, 2), success: true },
          ]

          result = described_class.new(review_history).value

          expect(result).to eq(Date.new(1999, 1, 4))
        end
      end

      context "when difference between the first success and the last is 3d" do
        it "returns first successful review date + 2d + 3d" do
          review_history = [
            { date: Date.new(1999, 1, 1), success: true },
            { date: Date.new(1999, 1, 2), success: true },
            { date: Date.new(1999, 1, 4), success: true },
          ]

          result = described_class.new(review_history).value

          expect(result).to eq(Date.new(1999, 1, 7))
        end
      end

      context "when difference between the first success and the last is 7d" do
        it "returns first successful review date + 6d + 7d" do
          review_history = [
            { date: Date.new(1999, 1, 1), success: true },
            { date: Date.new(1999, 1, 2), success: true },
            { date: Date.new(1999, 1, 4), success: true },
            { date: Date.new(1999, 1, 7), success: true },
          ]

          result = described_class.new(review_history).value

          expect(result).to eq(Date.new(1999, 1, 14))
        end
      end

      context "when difference between the first success and the last is 14d" do
        it "returns first successful review date + 13d + 14d" do
          review_history = [
            { date: Date.new(1999, 1, 1), success: true },
            { date: Date.new(1999, 1, 2), success: true },
            { date: Date.new(1999, 1, 4), success: true },
            { date: Date.new(1999, 1, 7), success: true },
            { date: Date.new(1999, 1, 14), success: true },
          ]

          result = described_class.new(review_history).value

          expect(result).to eq(Date.new(1999, 1, 28))
        end
      end

      context "when there are failures in the set" do
        it "returns result based on most recent success" do
          review_history = [
            { date: Date.new(1999, 1, 1), success: true },
            { date: Date.new(1999, 1, 2), success: true },
            { date: Date.new(1999, 1, 4), success: true },
            { date: Date.new(1999, 1, 7), success: true },
            { date: Date.new(1999, 1, 14), success: false },
            { date: Date.new(1999, 1, 15), success: true },
            { date: Date.new(1999, 1, 16), success: true },
            { date: Date.new(1999, 1, 18), success: true },
          ]

          result = described_class.new(review_history).value

          expect(result).to eq(Date.new(1999, 1, 21))
        end
      end
    end
  end
end
