require 'rails_helper'

RSpec.describe "holds/index", type: :view do
  before(:each) do
    assign(:holds, [
      Hold.create!(
        user_id: "",
        type: "MyText"
      ),
      Hold.create!(
        user_id: "",
        type: "MyText"
      )
    ])
  end

  it "renders a list of holds" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
