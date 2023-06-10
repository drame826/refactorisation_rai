require 'rails_helper'

RSpec.describe League, type: :model do
  describe '#table_rows' do
    let(:league) { FactoryBot.create(:league) }
    let(:club_a) { FactoryBot.create(:club, name: "club_a", league: league) }
    let(:club_b) { FactoryBot.create(:club, name: "club_b", league: league) }
    let(:club_c) { FactoryBot.create(:club, name: "club_c", league: league) }

    context 'If there are no duplicate points' do
      # club_a: 1 wins 0 loss 1 draw / 4 points
      # club_b: 0 wins 0 loss 1 draw / 1 points
      # club_c: 0 wins 1 loss 0 draw / 0 points
      let!(:a_win_c_lost_match) { FactoryBot.create(:match, home_team: club_a, home_team_score: 1, away_team: club_c, away_team_score: 0, league: league) }
      let!(:a_and_b_draw_match) { FactoryBot.create(:match, home_team: club_a, home_team_score: 1, away_team: club_b, away_team_score: 1, league: league) }

      it 'League table data are output in order of points' do
        expect(league.table_rows.first.club).to eq club_a
        expect(league.table_rows.first.points).to eq 4
        expect(league.table_rows.second.club).to eq club_b
        expect(league.table_rows.second.points).to eq 1
        expect(league.table_rows.last.club).to eq club_c
        expect(league.table_rows.last.points).to eq 0
      end
    end

    context 'When there are overlapping points' do
      context 'When there is a goal difference' do
        # club_a: 1 wins 0 loss 0 draw / 3 points / goal difference +2
        # club_b: 1 wins 0 loss 0 draw / 3 points / goal difference +1
        # club_b: 0 wins 2 loss 0 draw / 0 points
        let!(:a_win_with_2_goals_against_c_match) { FactoryBot.create(:match, home_team: club_a, home_team_score: 2, away_team: club_c, away_team_score: 0, league: league) }
        let!(:b_win_with_1_goal_against_c_match) { FactoryBot.create(:match, home_team: club_b, home_team_score: 1, away_team: club_c, away_team_score: 0, league: league) }

        it 'League table data are output in order of goal difference' do
          expect(league.table_rows.first.club).to eq club_a
          expect(league.table_rows.first.rank).to eq 1
          expect(league.table_rows.first.points).to eq 3
          expect(league.table_rows.first.goal_difference).to eq 2

          expect(league.table_rows.second.club).to eq club_b
          expect(league.table_rows.second.rank).to eq 2
          expect(league.table_rows.second.points).to eq 3
          expect(league.table_rows.second.goal_difference).to eq 1

          expect(league.table_rows.last.club).to eq club_c
          expect(league.table_rows.last.rank).to eq 3
          expect(league.table_rows.last.points).to eq 0
        end
      end

      context 'When there is no goal difference' do
        context 'If there is no difference in the number of annual wins' do
          # club_a: 1 wins 0 loss 0 draw / 3 points / goal difference +1
          # club_b: 1 wins 0 loss 0 draw / 3 points / goal difference +1
          # club_c: 0 wins 2 loss 0 draw / 0 points / goal difference -2
          let!(:a_win_with_1_goal_against_c_match) { FactoryBot.create(:match, home_team: club_a, home_team_score: 1, away_team: club_c, away_team_score: 0, league: league) }
          let!(:b_win_with_1_goal_against_c_match) { FactoryBot.create(:match, home_team: club_b, home_team_score: 1, away_team: club_c, away_team_score: 0, league: league) }

          it 'League table data is output in the same ranking and in ascending order of club name' do
            expect(league.table_rows.first.club).to eq club_a
            expect(league.table_rows.first.rank).to eq 1
            expect(league.table_rows.first.points).to eq 3
            expect(league.table_rows.first.goal_difference).to eq 1

            expect(league.table_rows.second.club).to eq club_b
            expect(league.table_rows.second.rank).to eq 1
            expect(league.table_rows.second.points).to eq 3
            expect(league.table_rows.second.goal_difference).to eq 1

            expect(league.table_rows.last.club).to eq club_c
            expect(league.table_rows.last.rank).to eq 3
            expect(league.table_rows.last.points).to eq 0
          end
        end

        context 'If there is a difference in the number of wins per year' do
          let(:club_d) { FactoryBot.create(:club, name: "club_d", league: league) }

          # club_a: 2 wins 1 loss 0 draw / 6 points / goal difference +1
          # club_b: 1 wins 1 loss 3 draw / 6 points / goal difference +1
          let!(:a_win_with_1_goal_against_c_match) { FactoryBot.create(:match, home_team: club_a, home_team_score: 1, away_team: club_c, away_team_score: 0, league: league) }
          let!(:b_win_with_1_goal_against_c_match) { FactoryBot.create(:match, home_team: club_b, home_team_score: 1, away_team: club_c, away_team_score: 0, league: league) }
          let!(:a_win_with_1_goal_against_d_match) { FactoryBot.create(:match, home_team: club_a, home_team_score: 1, away_team: club_d, away_team_score: 0, league: league) }
          let!(:a_lost_with_1_goal_against_c_match) { FactoryBot.create(:match, home_team: club_a, home_team_score: 0, away_team: club_c, away_team_score: 1, league: league) }
          let!(:b_and_c_draw_match_without_goal) { FactoryBot.create(:match, home_team: club_b, home_team_score: 0, away_team: club_c, away_team_score: 0, league: league) }
          let!(:b_and_d_draw_match_without_goal_1) { FactoryBot.create(:match, home_team: club_b, home_team_score: 0, away_team: club_d, away_team_score: 0, league: league) }
          let!(:b_and_d_draw_match_without_goal_2) { FactoryBot.create(:match, home_team: club_b, home_team_score: 0, away_team: club_d, away_team_score: 0, league: league) }

          it 'League table data is output in order of the number of annual wins' do
            expect(league.table_rows.first.club).to eq club_a
            expect(league.table_rows.first.rank).to eq 1
            expect(league.table_rows.first.points).to eq 6
            expect(league.table_rows.first.goal_difference).to eq 1
            expect(league.table_rows.first.win).to eq 2

            expect(league.table_rows.second.club).to eq club_b
            expect(league.table_rows.second.rank).to eq 2
            expect(league.table_rows.second.points).to eq 6
            expect(league.table_rows.second.goal_difference).to eq 1
            expect(league.table_rows.second.win).to eq 1

            expect(league.table_rows[2].club).to eq club_c
            expect(league.table_rows[2].rank).to eq 3

            expect(league.table_rows.last.club).to eq club_d
            expect(league.table_rows.last.rank).to eq 4
          end
        end
      end
    end
  end
end
