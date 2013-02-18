# This file should contain all the record creation needed to seed the database
# with its initial data. The data can then be loaded via `rake db:seed`.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create all 347 NCAA Division I teams.
# http://www.ncaa.com/rankings/basketball-men/d1/ncaa_mens_basketball_rpi
# TODO: Update these teams by Selection Sunday.
Team.destroy_all
teams = Team.create([
  { :rank => 1, :name => "Duke" },
  { :rank => 2, :name => "Miami" },
  { :rank => 3, :name => "New Mexico" },
  { :rank => 4, :name => "Florida" },
  { :rank => 5, :name => "Michigan" },
  { :rank => 6, :name => "Syracuse" },
  { :rank => 7, :name => "Arizona" },
  { :rank => 8, :name => "Louisville" },
  { :rank => 9, :name => "Michigan St." },
  { :rank => 10, :name => "Kansas" },
  { :rank => 11, :name => "Indiana" },
  { :rank => 12, :name => "Gonzaga" },
  { :rank => 13, :name => "Minnesota" },
  { :rank => 14, :name => "Butler" },
  { :rank => 15, :name => "Colorado St." },
  { :rank => 16, :name => "Marquette" },
  { :rank => 17, :name => "N.C. State" },
  { :rank => 18, :name => "Oklahoma" },
  { :rank => 19, :name => "Colorado" },
  { :rank => 20, :name => "UNLV" },
  { :rank => 21, :name => "Belmont" },
  { :rank => 22, :name => "Kansas St." },
  { :rank => 23, :name => "Ohio St." },
  { :rank => 24, :name => "Connecticut" },
  { :rank => 25, :name => "Georgetown" },
  { :rank => 26, :name => "Oklahoma St." },
  { :rank => 27, :name => "Illinois" },
  { :rank => 28, :name => "San Diego St." },
  { :rank => 29, :name => "Middle Tenn." },
  { :rank => 30, :name => "Pittsburgh" },
  { :rank => 31, :name => "Wisconsin" },
  { :rank => 32, :name => "Memphis" },
  { :rank => 33, :name => "Missouri" },
  { :rank => 34, :name => "La Salle" },
  { :rank => 35, :name => "Cincinnati" },
  { :rank => 36, :name => "N. Carolina" },
  { :rank => 37, :name => "Iowa St." },
  { :rank => 38, :name => "UCLA" },
  { :rank => 39, :name => "VCU" },
  { :rank => 40, :name => "Temple" },
  { :rank => 41, :name => "Wichita St." },
  { :rank => 42, :name => "Oregon" },
  { :rank => 43, :name => "Creighton" },
  { :rank => 44, :name => "Notre Dame" },
  { :rank => 45, :name => "Ole Miss" },
  { :rank => 46, :name => "Indiana St." },
  { :rank => 47, :name => "Southern Miss." },
  { :rank => 48, :name => "Boise St." },
  { :rank => 49, :name => "Kentucky" },
  { :rank => 50, :name => "St. Mary's" },
  { :rank => 51, :name => "Louisiana Tech" },
  { :rank => 52, :name => "Massachusetts" },
  { :rank => 53, :name => "Akron" },
  { :rank => 54, :name => "Baylor" },
  { :rank => 55, :name => "St. John's" },
  { :rank => 56, :name => "Saint Louis" },
  { :rank => 57, :name => "Stanford" },
  { :rank => 58, :name => "Bucknell" },
  { :rank => 59, :name => "California" },
  { :rank => 60, :name => "BYU" },
  { :rank => 61, :name => "Charlotte" },
  { :rank => 62, :name => "Wyoming" },
  { :rank => 63, :name => "Villanova" },
  { :rank => 64, :name => "Alabama" },
  { :rank => 65, :name => "Western Ky." },
  { :rank => 66, :name => "Vermont" },
  { :rank => 67, :name => "Xavier" },
  { :rank => 68, :name => "Detroit" }
])

# Create and set up the official bracket.
Bracket.destroy_all
bracket = Bracket.create({ :is_official => true })
games = bracket.games.order("id ASC")
games[0][:team_one_id]  = teams[0][:id]  # round 1 (ro64)
games[8][:team_one_id]  = teams[1][:id]  # |
games[16][:team_one_id] = teams[2][:id]  # |
games[24][:team_one_id] = teams[3][:id]  # |
games[7][:team_one_id]  = teams[4][:id]  # |
games[15][:team_one_id] = teams[5][:id]  # |
games[23][:team_one_id] = teams[6][:id]  # |
games[31][:team_one_id] = teams[7][:id]  # |
games[5][:team_one_id]  = teams[8][:id]  # |
games[13][:team_one_id] = teams[9][:id]  # |
games[21][:team_one_id] = teams[10][:id] # |
games[29][:team_one_id] = teams[11][:id] # |
games[3][:team_one_id]  = teams[12][:id] # |
games[11][:team_one_id] = teams[13][:id] # |
games[19][:team_one_id] = teams[14][:id] # |
games[27][:team_one_id] = teams[15][:id] # |
games[2][:team_one_id]  = teams[16][:id] # |
games[10][:team_one_id] = teams[17][:id] # |
games[18][:team_one_id] = teams[18][:id] # |
games[26][:team_one_id] = teams[19][:id] # |
games[4][:team_one_id]  = teams[20][:id] # |
games[12][:team_one_id] = teams[21][:id] # |
games[20][:team_one_id] = teams[22][:id] # |
games[28][:team_one_id] = teams[23][:id] # |
games[6][:team_one_id]  = teams[24][:id] # |
games[14][:team_one_id] = teams[25][:id] # |
games[22][:team_one_id] = teams[26][:id] # |
games[30][:team_one_id] = teams[27][:id] # |
games[1][:team_one_id]  = teams[28][:id] # |
games[9][:team_one_id]  = teams[29][:id] # |
games[17][:team_one_id] = teams[30][:id] # |
games[25][:team_one_id] = teams[31][:id] # |
games[25][:team_two_id] = teams[32][:id] # |
games[17][:team_two_id] = teams[33][:id] # |
games[9][:team_two_id]  = teams[34][:id] # |
games[1][:team_two_id]  = teams[35][:id] # |
games[30][:team_two_id] = teams[36][:id] # |
games[22][:team_two_id] = teams[37][:id] # |
games[14][:team_two_id] = teams[38][:id] # |
games[6][:team_two_id]  = teams[39][:id] # |
games[28][:team_two_id] = teams[40][:id] # |
games[20][:team_two_id] = teams[41][:id] # |
games[12][:team_two_id] = teams[42][:id] # |
games[4][:team_two_id]  = teams[43][:id] # |
games[26][:team_two_id] = teams[44][:id] # |
games[18][:team_two_id] = teams[45][:id] # |
games[10][:team_two_id] = teams[46][:id] # |
games[2][:team_two_id]  = teams[47][:id] # |
games[27][:team_two_id] = teams[48][:id] # |
games[19][:team_two_id] = teams[49][:id] # |
games[11][:team_two_id] = teams[50][:id] # |
games[3][:team_two_id]  = teams[51][:id] # |
games[29][:team_two_id] = teams[52][:id] # |
games[21][:team_two_id] = teams[53][:id] # |
games[13][:team_two_id] = teams[54][:id] # |
games[5][:team_two_id]  = teams[55][:id] # |
games[31][:team_two_id] = teams[56][:id] # |
games[23][:team_two_id] = teams[57][:id] # |
games[15][:team_two_id] = teams[58][:id] # |
games[7][:team_two_id]  = teams[59][:id] # V
games[24][:team_two_id] = nil # winners from the first four
games[16][:team_two_id] = nil # |
games[8][:team_two_id]  = nil # |
games[0][:team_two_id]  = nil # V
games[63][:team_one_id] = teams[60][:id] # round 1 (first four)
games[64][:team_one_id] = teams[61][:id] # |
games[65][:team_one_id] = teams[62][:id] # |
games[66][:team_one_id] = teams[63][:id] # |
games[66][:team_two_id] = teams[64][:id] # |
games[65][:team_two_id] = teams[65][:id] # |
games[64][:team_two_id] = teams[66][:id] # |
games[63][:team_two_id] = teams[67][:id] # V
games.each { |game| game.save! }

# Create some dummy users.
User.destroy_all
unless Rails.env.production?
  User.create([
    { :name => "Courtland Allen", :fb_id => Constants::TEST_USER_FB_ID },
    { :name => "Channing Allen" },
    { :name => "Philip Garcia" },
    { :name => "Cristian Derr" },
    { :name => "Adrian Adames" },
    { :name => "Aaron Rosado" },
    { :name => "Luis Sura" },
    { :name => "Lynne Tye" },
    { :name => "Geraldine Lim" },
    { :name => "Angela Holloman" },
    { :name => "Dan Shively" }
  ])
end