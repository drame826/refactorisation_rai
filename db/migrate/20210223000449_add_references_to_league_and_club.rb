class AddReferencesToLeagueAndClub < ActiveRecord::Migration[6.0]
  def change
    add_reference :clubs, :league, null: false, foreign_key: true
  end
end
