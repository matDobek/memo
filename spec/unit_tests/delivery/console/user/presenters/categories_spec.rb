describe Delivery::Console::User::Presenters::Categories do
  it "should return proper view data" do
    categories = ["Science", "Maths"]
    result     = subject.present(categories)

    expect(result).to eq({
      categories: ["Science", "Maths"]
    })
  end
end
