require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  before { subject.save }

  it 'User does not have errors if name, email and password given' do
    expect(subject).to be_valid
  end

  it 'Name should not be nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Email should not be nil' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'Has many expenses' do
    create_list :expense, 5, author_id: subject.id
    expect(subject.expenses.length).to eql(5)
  end

  it 'Has many groups' do
    create_list :group, 3, user_id: subject.id
    expect(subject.groups.length).to eql(3)
  end
end
