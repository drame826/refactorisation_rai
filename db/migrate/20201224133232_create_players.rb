class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :firstname
      t.string :lastname
      t.string :position
      t.string :country
      t.date :birthday
      t.references :club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
