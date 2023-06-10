require 'rails_helper'

RSpec.describe Match, type: :model do
  describe '#winner' do

  context 'When not a draw' do
      let(:winner_club) { FactoryBot.create(:club, name: "Winner") }
      let(:match) { FactoryBot.create(:match, home_team: winner_club, home_team_score: 2, away_team_score: 0) }

      it 'The winning club is returned' do
        expect(match.winner).to eq winner_club
      end
    end

    context 'When a draw' do
      let(:draw_match) { FactoryBot.create(:match, home_team_score: 0, away_team_score: 0) }

      it 'nil is returned' do
        expect(draw_match.winner).to be nil
      end
    end
  end
end
