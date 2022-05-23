require 'rails_helper'

RSpec.describe "expenses/show", type: :view do
  before(:each) do
    @expense = assign(:expense, Expense.create!(
      name: "Name",
      amount: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
