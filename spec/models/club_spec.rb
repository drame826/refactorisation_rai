require 'rails_helper'

RSpec.describe Club, type: :model do
  describe '#matches' do
    let(:club_a) { FactoryBot.create(:club, name: "Club A") }
    let(:club_b) { FactoryBot.create(:club, name: "Club B") }
    let(:club_c) { FactoryBot.create(:club, name: "Club C") }

    let(:home_match) { FactoryBot.create(:match, home_team: club_a, away_team: club_b)}
    let(:away_match) { FactoryBot.create(:match, home_team: club_b, away_team: club_a)}
    let!(:not_participated_match) { FactoryBot.create(:match, home_team: club_b, away_team: club_c)}

    it 'Only matches where your club is home_team or away_team are returned' do
      expect(club_a.matches).to match_array([home_match, away_match])
    end
  end

  describe '#matches_on' do
    let(:club_a) { FactoryBot.create(:club, name: "Club A") }

    let(:match_on_current_year) { FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.year, 1, 1), home_team: club_a)}
    let!(:match_on_past_year) { FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.years_ago(1).year, 1, 1), home_team: club_a)}
    let!(:match_on_future_year) { FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.years_since(1).year, 1, 1), home_team: club_a)}
    let!(:match_on_current_year_not_participated_in) { FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.year, 1, 1)) }

    context 'When year is specified' do
      let(:year) { Date.current.year }

      it 'Only match is returned where the club is home_team or away_team and kicked_of_at is the year when the spec was run.' do
        expect(club_a.matches_on(year)).to match_array([match_on_current_year])
      end
    end

    context 'When year is specified' do
      let(:year) { nil }

      it 'nil returned' do
        expect(club_a.matches_on(year)).to eq nil
      end
    end
  end

  describe '#win_on' do
    let(:club_a) { FactoryBot.create(:club, name: "Club A") }

    before do
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: club_a, home_team_score: 2, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: club_a, home_team_score: 0, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: club_a, home_team_score: 0, away_team_score: 2)
    end

    it 'Number of games won(1) is returned' do
      expect(club_a.win_on(Date.current.year)).to eq 1
    end
  end

  describe '#won?' do
    let(:club_a) { FactoryBot.create(:club, name: "Club A") }
    let(:won_match) { FactoryBot.create(:match, kicked_off_at: Date.current, home_team: club_a, home_team_score: 2, away_team_score: 0)}

    before do
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: club_a, home_team_score: 2, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: club_a, home_team_score: 0, away_team_score: 0)
      FactoryBot.create(:match, kicked_off_at: Date.current, home_team: club_a, home_team_score: 0, away_team_score: 2)
    end

    it 'true' do
      expect(club_a.won?(won_match)).to be_truthy
    end
  end
end
