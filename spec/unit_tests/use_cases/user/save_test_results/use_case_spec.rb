describe UseCases::User::SaveTestResults::UseCase do
  include_context "tmp_review_repository_file_path, clear_tmp_review_repository!"

  let(:reviews_gateway) do
    DataInterfaces::File::Gateways::Review.new(tmp_review_repository_file_path)
  end

  subject do
    described_class.new(reviews_gateway: reviews_gateway)
  end

  describe "#execute" do
    after do
      clear_tmp_review_repository!
    end

    it "adds results, with current date to the repository" do
      results = [
        { id: 1, success: true },
        { id: 2, success: false },
      ]

      Timecop.freeze(Date.new(1999, 01, 01)) do
        subject.execute(results: results)

        reviews_collection = reviews_gateway.all.map(&:to_h)

        expect(reviews_collection).to include({
          memo_id: "1",
          date: Date.new(1999, 01, 01),
          success: true,
        })

        expect(reviews_collection).to include({
          memo_id: "2",
          date: Date.new(1999, 01, 01),
          success: false,
        })
      end
    end
  end
end
