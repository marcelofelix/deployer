require 'securerandom'

FactoryGirl.define do
  factory :user do
    provider 'github'
    uid SecureRandom.uuid
    logo { name }
  end
end
