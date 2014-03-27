FactoryGirl.define do
  factory :user do
    name     "Brent Vale"
    email    "brent@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end