require "spec_helper"



FactoryGirl.define do
  factory :slide do
    association :slideset
    image   { get_image_stream }
  end
  
  factory :slideset do
    title { "test" }
  end
  
  factory :annotation do
    association :slide
    annotation { Faker::Lorem.words(1) }
  end
end
