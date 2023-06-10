require 'rails_helper'

describe 'Club CRUD functions', type: :system do
  describe 'Club details page' do
    describe 'Screen transition function' do
      let!(:club) { FactoryBot.create(:club, name: "Blue FC") }

      before do
        first_match_on_last_year =
          FactoryBot.create(:match, kicked_off_at: Date.new(Date.current.year, 1, 1), home_team: club, home_team_score: 1, away_team_score: 0)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(1), home_team: club, home_team_score: 0, away_team_score: 1)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(2), home_team: club, home_team_score: 0, away_team_score: 1)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(3), home_team: club, home_team_score: 0, away_team_score: 1)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(4), home_team: club, home_team_score: 0, away_team_score: 0)
        FactoryBot.create(:match, kicked_off_at: first_match_on_last_year.kicked_off_at.weeks_since(5), home_team: club, home_team_score: 0, away_team_score: 0)

        # create 20, 25, and 30 years old players. Average should be 25
        FactoryBot.create(:player, club: club, birthday: Date.current.years_ago(20), firstname: "Taro", lastname: "Tanaka")
        FactoryBot.create(:player, club: club, birthday: Date.current.years_ago(25))
        FactoryBot.create(:player, club: club, birthday: Date.current.years_ago(30))
      end

      context 'When accessing the club details page' do
        before do
          visit club_path(club)
        end

        it 'The match results is displayed correctly' do
          expect(page).to have_content "matches: 6 won: 1 lost: 3 draw: 2"
        end

        it 'The full name of the player is displayed correctly' do
          expect(page).to have_content 'Taro Tanaka'
        end

        it 'The average age of the players is displayed correctly' do
          expect(page).to have_content '25.0'
        end
      end
    end
  end
end
