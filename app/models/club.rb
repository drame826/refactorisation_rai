class Club < ApplicationRecord
  has_one_attached :logo

  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"
  has_many :players
  belongs_to :league

  def matches
    Match.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

  def matches_on(year = nil)
    return nil unless year

    matches.where(kicked_off_at: Date.new(year, 1, 1).in_time_zone.all_year)
  end

  def won?(match)
    match.winner == self
  end

  def lost?(match)
    match.loser == self
  end

  def draw?(match)
    match.draw?
  end

  def win_on(year)
    count_by(year, "won?")
  end

  def lost_on(year)
    count_by(year, "lost?")
  end

  def draw_on(year)
    count_by(year, "draw?")
  end

  def players_average_age
    (self.players.sum(&:age) / self.players.length).to_f
  end

  def homebase
    "#{hometown}, #{country}"
  end

  private
  def count_by(year, result)
    year = Date.new(year, 1, 1)
    count = 0
    matches.where(kicked_off_at: year.all_year).each do |match|
      count += 1 if send(result, match)
    end
    count
  end
end