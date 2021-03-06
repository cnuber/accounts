FactoryGirl.define do
  factory :user do
    username { SecureRandom.hex(3) }
    person
    is_temp false

    trait :admin do
      is_administrator true
    end

    factory :temp_user do
      person nil
      is_temp true
    end

    trait :terms_agreed do
      after(:create) do |user, evaluator|
        FinePrint::Contract.all.each do |contract|
          FinePrint.sign_contract(user, contract)
        end
      end
    end

    factory :user_with_emails do
      ignore do
        emails_count 2
      end

      # Leaving this here to show how to do :create instead of :build
      # after(:create) do |user, evaluator|
      #   FactoryGirl.create_list(:email_address, evaluator.emails_count, user: user)
      # end

      after(:build) do |user, evaluator|
        evaluator.emails_count.times do 
          user.contact_infos << FactoryGirl.build(:email_address)
        end
      end
    end
  end
  
end
