FactoryBot.define do
  factory :book_loan do
    user { build(:user) }
    book { build(:book) }
    due_date { Faker::Date.forward(days: 23) }
  end
end
