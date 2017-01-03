FactoryGirl.define do
  sequence :version_number do |n|
    n
  end

  factory :version do
    name { generate :version_number }
    project
  end
end
