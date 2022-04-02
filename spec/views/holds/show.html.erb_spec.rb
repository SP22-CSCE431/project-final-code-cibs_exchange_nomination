require 'rails_helper'

RSpec.describe "holds/show", type: :view do
  before(:each) do
    @hold = assign(:hold, Hold.create!(
      user_id: "",
      type: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
