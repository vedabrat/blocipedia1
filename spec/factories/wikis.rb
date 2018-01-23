FactoryBot.define do
  factory :wiki do
    title "MyString"
    body "MyText"
    private false
    collaborators ""
    user nil
  end
end
