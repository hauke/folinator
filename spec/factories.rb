require "spec_helper"


FactoryGirl.define do
  factory :slide do
    association :slideset
    image   { get_image_stream }
  end
  
  factory :slideset do
    title { "test" }
  end
end
