class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.datetime :kicked_off_at
      t.references :league, null: false, foreign_key: true
      t.references :home_team, null: false, foreign_key: { to_table: "clubs" }
      t.references :away_team, null: false, foreign_key: { to_table: "clubs" }
      t.integer :home_team_score
      t.integer :away_team_score

      t.timestamps
    end
  end
end
