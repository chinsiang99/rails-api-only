FactoryBot.define do
  factory :book do
    # title { "Default Book Name" }
    # author { "Default Author Name" }
    association :author
  end
end
