# This file should contain all the record creation needed to seed the database
# with its initial data. The data can then be loaded via `rake db:seed`.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create all 347 NCAA Division I teams.
# http://www.ncaa.com/rankings/basketball-men/d1/ncaa_mens_basketball_rpi
# TODO: Update these teams by Selection Sunday.
Team.destroy_all
Team.create([
  { :rank => 1, :name => "Duke" },
  { :rank => 2, :name => "Miami (Fla.)" },
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
  { :rank => 17, :name => "North Carolina St." },
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
  { :rank => 36, :name => "North Carolina" },
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
  { :rank => 50, :name => "St. Mary's (Calif.)" },
  { :rank => 51, :name => "Louisiana Tech" },
  { :rank => 52, :name => "Massachusetts" },
  { :rank => 53, :name => "Akron" },
  { :rank => 54, :name => "Baylor" },
  { :rank => 55, :name => "St. John's (N.Y.)" },
  { :rank => 56, :name => "Saint Louis" },
  { :rank => 57, :name => "Stanford" },
  { :rank => 58, :name => "Bucknell" },
  { :rank => 59, :name => "California" },
  { :rank => 60, :name => "BYU" },
  { :rank => 61, :name => "Charlotte" },
  { :rank => 62, :name => "Wyoming" },
  { :rank => 63, :name => "Villanova" },
  { :rank => 64, :name => "Alabama" }
])

# Create the official bracket.
Bracket.destroy_all
Bracket.create({ :is_official => true })

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