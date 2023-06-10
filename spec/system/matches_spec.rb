require 'rails_helper'

describe ' CRUD function of match results', type: :system do
  describe 'Match results index page' do
    describe 'Redirect function' do
      before do
        home = FactoryBot.create(:club, name: "Home FC")
        away = FactoryBot.create(:club, name: "Away FC")
        FactoryBot.create(:match, home_team: home, home_team_score: 2, away_team_score: 0, away_team: away, kicked_off_at: DateTime.new(2021, 1, 1, 19, 00))
      end

      context 'When user access match results index page' do
        before do
          visit root_path
        end

        it 'match results displayed' do
          expect(page).to have_content 'Matche Results'
          expect(page).to have_content 'Home FC'
          expect(page).to have_content 'Away FC'
          expect(page).to have_content '2021-01-01 19:00'
        end
      end
    end
  end

  describe 'Page for create match result' do
    describe 'Match result creation' do
      before do
        hoge_league = FactoryBot.create(:league, name: "Hoge League")
        FactoryBot.create(:club, name: "Home FC", league: hoge_league)
        FactoryBot.create(:club, name: "Away FC", league: hoge_league)

        visit new_match_path
      end

      context 'When kick off time, clubs, and scores entered' do
        before do
          select '2021', from: 'match[kicked_off_at(1i)]'
          select 'January', from: 'match[kicked_off_at(2i)]'
          select '1', from: 'match[kicked_off_at(3i)]'
          select '19', from: 'match[kicked_off_at(4i)]'
          select '30', from: 'match[kicked_off_at(5i)]'
          select 'Hoge League', from: 'match[league_id]'
          select 'Home FC', from: 'match[home_team_id]'
          select 'Away FC', from: 'match[away_team_id]'
          fill_in 'match_home_team_score', with: 2
          fill_in 'match_away_team_score', with: 0

          click_on 'Create Match'
        end

        it 'Match created successfully' do
          expect(page).to have_content '2021-01-01 19:30'
          expect(page).to have_content 'Home FC'
          expect(page).to have_content 'Away FC'
          expect(page).to have_content "Home team score: 2"
          expect(page).to have_content "Away team score: 0"
        end
      end
    end
  end
end
