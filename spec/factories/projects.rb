FactoryGirl.define do
  sequence :project do |n|
    "Porject #{n}"
  end

  factory :project do
    name { generate(:project) }
    bucket_name { "bucket.#{name}" }
    region 'us-east-1'
  end
end
