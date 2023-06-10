class CreateClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :established_on
      t.string :hometown
      t.string :country
      t.string :color
      t.string :manager

      t.timestamps
    end
  end
end
