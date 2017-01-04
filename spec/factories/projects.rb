FactoryGirl.define do

  sequence :project do |n|
    "Porject #{n}"
  end

  factory :project do
    name { generate(:project) }
    bucket_name { "bucket.#{name}" }
  end
end
