# frozen_string_literal: true

FactoryBot.define do
  factory :banner_item do
    title { 'Mobile' }
    image_url do
      'https://imgk.timesnownews.com/story/
    	1556453812-Realme_3_pro_0.jpg?tr=w-400,h-300,fo-auto'
    end
    web_params { '' }
    mobile_params { '' }
  end
end
