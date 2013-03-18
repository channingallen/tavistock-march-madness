# This file should contain all the record creation needed to seed the database
# with its initial data. The data can then be loaded via `rake db:seed`.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Destroy the official bracket and wipe the teams table.
bracket = Bracket.where(:is_official=>true).first
bracket.destroy
Team.destroy_all

# Create a new official bracket.
bracket = Bracket.create(:is_official => true)
games = bracket.games.order("id ASC")

# First Four
nc_a_and_t = Team.create(:rank => 16, :name => "N.C. A&T")
liberty = Team.create(:rank => 16, :name => "Liberty")
games[63][:team_one_id] = nc_a_and_t.id
games[63][:team_two_id] = liberty.id
middle_tennesee = Team.create(:rank => 11, :name => "Middle Tenn.")
st_marys = Team.create(:rank => 11, :name => "St. Mary's")
games[64][:team_one_id] = middle_tennesee.id
games[64][:team_two_id] = st_marys.id
boise_state = Team.create(:rank => 13, :name => "Boise State")
la_salle = Team.create(:rank => 13, :name => "La Salle")
games[65][:team_one_id] = boise_state.id
games[65][:team_two_id] = la_salle.id
liu_brooklyn = Team.create(:rank => 16, :name => "LIU-Brooklyn")
james_madison = Team.create(:rank => 16, :name => "J. Madison")
games[66][:team_one_id] = liu_brooklyn.id
games[66][:team_two_id] = james_madison.id

# Top-Left Region
louisville = Team.create(:rank => 1, :name => "Louisville")
games[0][:team_one_id]  = louisville.id
games[0][:team_two_id]  = nil
colorado_st = Team.create(:rank => 8, :name => "Colorado St")
missouri = Team.create(:rank => 9, :name => "Missouri")
games[1][:team_one_id]  = colorado_st.id
games[1][:team_two_id]  = missouri.id
oklahoma_st = Team.create(:rank => 5, :name => "Oklahoma St.")
oregon = Team.create(:rank => 12, :name => "Oregon")
games[2][:team_one_id]  = oklahoma_st.id
games[2][:team_two_id]  = oregon.id
saint_louis = Team.create(:rank => 4, :name => "Saint Louis")
new_mex_st = Team.create(:rank => 13, :name => "New Mex. St.")
games[3][:team_one_id]  = saint_louis.id
games[3][:team_two_id]  = new_mex_st.id
memphis = Team.create(:rank => 6, :name => "Memphis")
games[4][:team_one_id]  = memphis.id
games[4][:team_two_id]  = nil
michigan_st = Team.create(:rank => 3, :name => "Michigan St.")
valparaiso = Team.create(:rank => 14, :name => "Valparaiso")
games[5][:team_one_id]  = michigan_st.id
games[5][:team_two_id]  = valparaiso.id
creighton = Team.create(:rank => 7, :name => "Creighton")
cincinnati = Team.create(:rank => 10, :name => "Cincinnati")
games[6][:team_one_id]  = creighton.id
games[6][:team_two_id]  = cincinnati.id
duke = Team.create(:rank => 2, :name => "Duke")
albany = Team.create(:rank => 15, :name => "Albany")
games[7][:team_one_id]  = duke.id
games[7][:team_two_id]  = albany.id

# Bottom-Left Region
gonzaga = Team.create(:rank => 1, :name => "Gonzaga")
southern_u = Team.create(:rank => 16, :name => "Southern U.")
games[8][:team_one_id]  = gonzaga.id
games[8][:team_two_id]  = southern_u.id
pittsburgh = Team.create(:rank => 8, :name => "Pittsburgh")
wichita_st = Team.create(:rank => 9, :name => "Wichita St.")
games[9][:team_one_id]  = pittsburgh.id
games[9][:team_two_id]  = wichita_st.id
wisconsin = Team.create(:rank => 5, :name => "Wisconsin")
ole_miss = Team.create(:rank => 12, :name => "Ole Miss")
games[10][:team_one_id] = wisconsin.id
games[10][:team_two_id] = ole_miss.id
kansas_st = Team.create(:rank => 4, :name => "Kansas St.")
games[11][:team_one_id] = kansas_st.id
games[11][:team_two_id] = nil
arizona = Team.create(:rank => 6, :name => "Arizona")
belmont = Team.create(:rank => 11, :name => "Belmont")
games[12][:team_one_id] = arizona.id
games[12][:team_two_id] = belmont.id
new_mexico = Team.create(:rank => 3, :name => "New Mexico")
harvard = Team.create(:rank => 14, :name => "Harvard")
games[13][:team_one_id] = new_mexico.id
games[13][:team_two_id] = harvard.id
notre_dame = Team.create(:rank => 7, :name => "Notre Dame")
iowa_st = Team.create(:rank => 10, :name => "Iowa St.")
games[14][:team_one_id] = notre_dame.id
games[14][:team_two_id] = iowa_st.id
ohio_st = Team.create(:rank => 2, :name => "Ohio St.")
iona = Team.create(:rank => 15, :name => "Iona")
games[15][:team_one_id] = ohio_st.id
games[15][:team_two_id] = iona.id

# Top-Right Region
kansas = Team.create(:rank => 1, :name => "Kansas")
western_ky = Team.create(:rank => 16, :name => "Western ky.")
games[16][:team_one_id] = kansas.id
games[16][:team_two_id] = western_ky.id
n_carolina = Team.create(:rank => 8, :name => "N. Carolina")
villanova = Team.create(:rank => 9, :name => "Villanova")
games[17][:team_one_id] = n_carolina.id
games[17][:team_two_id] = villanova.id
vcu = Team.create(:rank => 5, :name => "VCU")
akron = Team.create(:rank => 12, :name => "Akron")
games[18][:team_one_id] = vcu.id
games[18][:team_two_id] = akron.id
michigan = Team.create(:rank => 4, :name => "Michigan")
s_dak_st = Team.create(:rank => 13, :name => "S. Dak. St.")
games[19][:team_one_id] = michigan.id
games[19][:team_two_id] = s_dak_st.id
ucla = Team.create(:rank => 6, :name => "UCLA")
minnesota = Team.create(:rank => 11, :name => "Minnesota")
games[20][:team_one_id] = ucla.id
games[20][:team_two_id] = minnesota.id
florida = Team.create(:rank => 3, :name => "Florida")
northwestern_st = Team.create(:rank => 4, :name => "Northwestern St.")
games[21][:team_one_id] = florida.id
games[21][:team_two_id] = northwestern_st.id
san_diego_st = Team.create(:rank => 7, :name => "San Diego St.")
oklahoma = Team.create(:rank => 10, :name => "Oklahoma")
games[22][:team_one_id] = san_diego_st.id
games[22][:team_two_id] = oklahoma.id
georgetown = Team.create(:rank => 2, :name => "Georgetown")
fgcu = Team.create(:rank => 15, :name => "FGCU")
games[23][:team_one_id] = georgetown.id
games[23][:team_two_id] = fgcu.id

# Bottom-Right Region
indiana = Team.create(:rank => 1, :name => "Indiana")
games[24][:team_one_id] = indiana.id
games[24][:team_two_id] = nil
nc_state = Team.create(:rank => 8, :name => "N.C. State")
temple = Team.create(:rank => 9, :name => "Temple")
games[25][:team_one_id] = nc_state.id
games[25][:team_two_id] = temple.id
unlv = Team.create(:rank => 5, :name => "UNLV")
california = Team.create(:rank => 12, :name => "California")
games[26][:team_one_id] = unlv.id
games[26][:team_two_id] = california.id
syracuse = Team.create(:rank => 4, :name => "Syracuse")
montana = Team.create(:rank => 13, :name => "Montana")
games[27][:team_one_id] = syracuse.id
games[27][:team_two_id] = montana.id
butler = Team.create(:rank => 6, :name => "Butler")
bucknell = Team.create(:rank => 11, :name => "Bucknell")
games[28][:team_one_id] = butler.id
games[28][:team_two_id] = bucknell.id
marquette = Team.create(:rank => 3, :name => "Marquette")
davidson = Team.create(:rank => 14, :name => "Davidson")
games[29][:team_one_id] = marquette.id
games[29][:team_two_id] = davidson.id
illinois = Team.create(:rank => 7, :name => "Illinois")
colorado = Team.create(:rank => 10, :name => "Colorado")
games[30][:team_one_id] = illinois.id
games[30][:team_two_id] = colorado.id
miami_fla = Team.create(:rank => 2, :name => "Miami (Fla.)")
pacific = Team.create(:rank => 15, :name => "Pacific")
games[31][:team_one_id] = miami_fla.id
games[31][:team_two_id] = pacific.id

# Finalize games for the initial bracket.
games.each { |game| game.save! }

# Update existing users' brackets to copy the official bracket.
User.all.each do |user|
  user.bracket.destroy
  bracket = Bracket.new
  bracket.user_id = user.id
  bracket.save
end