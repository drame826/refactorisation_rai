class Player < ApplicationRecord
  belongs_to :club

  def age
    ((Time.zone.now  - birthday.to_time) / 1.year.seconds).floor
  end
end
