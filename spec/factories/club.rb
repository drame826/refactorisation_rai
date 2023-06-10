FactoryBot.define do
  factory :club do
    name { 'hoge' }
    established_on { 1900 }
    hometown { 'hoge' }
    country { 'hoge' }
    manager { 'hoge' }
    league { FactoryBot.create(:league) }

    after(:build) do |club|
      club.logo.attach(io: File.open('spec/fixtures/logos/logo_birmingham_united_fc.png'), filename: 'logo_birmingham_united_fc.png', content_type: 'image/png')
    end
  end
end
