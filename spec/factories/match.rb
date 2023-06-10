FactoryBot.define do
  factory :match do
    kicked_off_at { Time.current - 1.hours }
    league { FactoryBot.create(:league) }
    home_team { FactoryBot.create(:club) }
    away_team { FactoryBot.create(:club) }
    home_team_score { 2 }
    away_team_score { 0 }
  end
end
