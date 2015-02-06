FactoryGirl.define do
  factory :user do
    first_name 'First'
    last_name 'Last'
    sequence(:email) {|n| "user#{n}@example.com"}
    sequence(:profile_name) {|n| "user#{n}"}

    password "mypassword"
    password_confirmation "mypassword"
  end

  factory :user_friendship do
    asociation :user, factory: :user
    association :friend, facotry: :user

    factory :pending_user_friendship do
      state 'pending'
    end

    factory :request_user_friendship do
      state 'requested'
    end

    factory :accepted_user_friendship do
      state 'accepted'
    end
  end
end