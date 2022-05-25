require 'faker'

FactoryBot.define do
  factory :group do
      name { Faker::Name.name }
      user_id {1}
      association :user, :factory => :user
      after(:build) do |attachment|
        attachment.icon.attach(io: File.open(Rails.root.join("spec", "resources", "image.jpg")), filename: 'image.jpg')
      end
  end
end