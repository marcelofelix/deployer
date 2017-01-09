FactoryGirl.define do
  factory :environment do
    name 'Production'
    project
    bucket_name 'production'
    version '123'
  end
end
