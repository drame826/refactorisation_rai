# seeds.rb で生成したい選手データの配列をあらかじめ生成し、seeds.rb にコピペして使う
# seeds.rb で以下の処理を直接行うと実行のたびに選手名が異なってしまい指導しづらくなる場面が想定されるため、あえてこのようにしている

require 'faker'
require 'gimei'

def generate_japanese_attributes
  firstname = "\'#{Gimei.unique.male.first.romaji}\'"
  lastname = "\'#{Gimei.unique.male.last.romaji}\'"

  country = "\'Japan\'"

  [firstname, lastname, country]
end

def generate_attributes
  firstname = "\'#{Faker::Name.male_first_name}\'"
  lastname = "\'#{Faker::Name.last_name}\'"

  country = ["\'Japan\'", "\'England\'", "\'France\'", "\'Brazil\'", "\'Argentina\'", "\'Portugal\'", "\'Germany\'", "\'Senegal\'", "\'Argeria\'", "\'Netherlands\'", "\'Spain\'", "\'Belgium\'", "\'Italy\'"].sample

  [firstname, lastname, country]
end

def player(firstname, lastname, position, country)
  "{ firstname: #{firstname}, lastname: #{lastname}, position: #{position}, country: #{country}, birthday: Random.rand(Date.new(1975, 1, 1)...Date.new(1991, 12, 31)), club: Club.find_by(name: 'FC') },\n"
end

players = ""

3.times do
  firstname, lastname, country = generate_attributes
  position = "\'FW\'"
  players << player(firstname, lastname, position, country)
end

7.times do
  firstname, lastname, country = generate_attributes
  position = "\'MF\'"
  players << player(firstname, lastname, position, country)
end

6.times do
  firstname, lastname, country = generate_attributes
  position = "\'DF\'"
  players << player(firstname, lastname, position, country)
end

3.times do
  firstname, lastname, country = generate_attributes
  position = "\'GK\'"
  players << player(firstname, lastname, position, country)
end

puts "======= paste below into array 'players' in seeds.rb. ========\n\n" + players
