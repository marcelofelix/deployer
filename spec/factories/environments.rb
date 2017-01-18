FactoryGirl.define do
  factory :environment do
    name 'Production'
    project
    bucket_name 'production'
    version '123'
    region 'us-east-1'
  end
end
