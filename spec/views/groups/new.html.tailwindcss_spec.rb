require 'rails_helper'

RSpec.describe "groups/new", type: :view do
  before(:each) do
    assign(:group, Group.new(
      name: "MyString",
      total_expenses: 1
    ))
  end

  it "renders new group form" do
    render

    assert_select "form[action=?][method=?]", groups_path, "post" do

      assert_select "input[name=?]", "group[name]"

      assert_select "input[name=?]", "group[total_expenses]"
    end
  end
end
