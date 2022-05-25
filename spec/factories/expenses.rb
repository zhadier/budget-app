require 'faker'

FactoryBot.define do
  factory :expense do
      name { Faker::Name.name }
      amount {Faker::Number.non_zero_digit}
      association :author, :factory => :user
      factory :expense_with_groups do
        groups { [association(:group)] }
      end
  end
end