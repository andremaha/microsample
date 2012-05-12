FactoryGirl.define do
  factory :user do
    name      'Andrey Esaulov'
    email     'aesaulov@me.com'
    password  'secret'
    password_confirmation 'secret'
  end
end