FactoryBot.define do
  factory :player do
    firstname { 'John' }
    lastname { 'Doe' }
    position { 'FW' }
    country { 'Japan' }
    birthday { Date.new(1989, 1, 1) }
    club { FactoryBot.create(:club) }
  end
end
