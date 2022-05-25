require 'rails_helper'

RSpec.describe '/groups', type: :request do
  let(:user) { create(:user) }
  before(:example) do
    sign_in user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get groups_url
      expect(response).to render_template('groups/index')
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_group_url(1)
      expect(response).to be_successful
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested group' do
      group = create(:group)
      expect do
        delete group_url(group)
      end.to change(Group, :count).by(-1)
    end

    it 'redirects to the groups list' do
      group = create(:group)
      delete group_url(group)
      expect(response).to redirect_to(groups_url)
    end
  end
end
