# -*- encoding : utf-8 -*-
require "spec_helper"



FactoryGirl.define do
  factory :slide do
    association :slideset
    image   { get_image_stream }
  end
  
  factory :slideset do
    title { "test" }
    association :lecture
  end

  factory :lecture do
    title { "test" }
  end
  
  factory :annotation do
    association :slide
    annotation { Faker::Lorem.words(1)[0] }
    association :last_author, :factory => :user
  end
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

FactoryGirl.define do
  factory :user do
    name         { Faker::Name.name }
    email        { Factory.next :email }
    identity_url { 'https://openid.tzi.de/' << email.split("@").first }
  end

  factory :admin, :parent => :user do
    admin true
  end
end
