require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) {create(:user)}
  subject { create(:group, user_id: user.id) }
  before { subject.save }

  it 'Group does not have errors if name and icon are present' do
    expect(subject).to be_valid
  end

  it 'Name should not be nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Name should be atleast 3 chars long' do
    subject.name = 'ab'
    expect(subject).to_not be_valid
  end

  it 'Icon should not be nil' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end

  it 'total_expenses is not nil' do
    subject.total_expenses = nil
    expect(subject).to_not be_valid
  end

  it 'total_expenses is > 0' do
    subject.total_expenses = -1
    expect(subject).to_not be_valid
  end

  it 'Has many expenses' do
    create_list :expense, 5, groups:[subject]
    expect(subject.expenses.length).to eql(5)
  end

  it 'Has a user' do
    expect(subject.user).to eql(user)
  end
end
