json.extract! player, :id, :firstname, :lastname, :position, :country, :birthday, :club_id, :created_at, :updated_at
json.url player_url(player, format: :json)
