class DestroyColorOfClub < ActiveRecord::Migration[6.0]
  def change
    remove_column :clubs, :color
  end
end
