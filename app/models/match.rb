class Match < ApplicationRecord
  belongs_to :league
  belongs_to :home_team, class_name: "Club", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "Club", foreign_key: "away_team_id"

  scope :draw, -> { where("home_team_score = away_team_score") }

  validates :home_team_score, :away_team_score, presence: true
  validate :same_club_must_not_play_same_match

  def winner
    return nil if draw?

    if home_team_score > away_team_score
      home_team
    elsif away_team_score > home_team_score
      away_team
    end
  end

  def loser
    return nil if draw?

    if away_team_score > home_team_score
      home_team
    elsif home_team_score > away_team_score
      away_team
    end
  end

  def draw?
    home_team_score == away_team_score
  end

  def goal_by(club)
    if club == home_team
      home_team_score
    elsif club == away_team
      away_team_score
    else
      0
    end
  end

  def goal_conceded_by(club)
    if club == home_team
      away_team_score
    elsif club == away_team
      home_team_score
    else
      0
    end
  end

  private

  def same_club_must_not_play_same_match
    errors.add(:base, "home team and away team must be different") if home_team == away_team
  end
end
