require 'rails_helper'

RSpec.describe "/expenses", type: :request do

  let(:user) {create(:user)}
  let(:group) {create(:group)}
  
  let(:valid_attributes) {
    {name:'Name', amount:23, selected_groups: [group.id, ''], author_id: user.id}
  }

  let(:invalid_attributes) {
    {name: '1', amount: 'gfdg', selected_groups: [group.id, '']}
  }

  before(:example) do
    sign_in user  
  end

  describe "GET /index" do
    it "renders a successful response" do
      get group_expenses_url(group.id)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_group_expense_url(group.id)
      expect(response).to be_successful
    end
  end


  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Expense" do
        expect {
          post group_expenses_url(group.id), params: { expense: valid_attributes }
        }.to change(Expense, :count).by(1)
      end

      it "redirects to the created expense" do
        post group_expenses_url(group.id), params: { expense: valid_attributes }
        expect(response).to redirect_to(group_expenses_url(group.id))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Expense" do
        expect {
          post group_expenses_url(group.id), params: { expense: invalid_attributes }
        }.to change(Expense, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post group_expenses_url(group.id), params: { expense: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested expense" do
      expense = create(:expense)
      expect {
        delete group_expense_url(group.id, expense.id)
      }.to change(Expense, :count).by(-1)
    end

    it "redirects to the expenses list" do
      expense = create(:expense)
      delete group_expense_url(group.id, expense.id)
      expect(response).to redirect_to(group_expenses_url(group.id))
    end
  end
end
