require 'rails_helper'

RSpec.describe Player, type: :model do
  describe '#age' do
    let(:player) { FactoryBot.create(:player, birthday: Date.current.years_ago(20)) }

    it 'Return the age calculated from the birthday' do
      expect(player.age).to eq 20
    end
  end
end
