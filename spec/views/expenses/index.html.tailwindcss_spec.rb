require 'rails_helper'

RSpec.describe "expenses/index", type: :view do
  before(:each) do
    assign(:expenses, [
      Expense.create!(
        name: "Name",
        amount: 2
      ),
      Expense.create!(
        name: "Name",
        amount: 2
      )
    ])
  end

  it "renders a list of expenses" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
