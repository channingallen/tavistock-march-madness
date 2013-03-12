module Constants

  # Phase
  # "testing"     - all brackets are editable
  # "preparation" - no brackets are editable
  # "selection"   - individual brackets are editable, but the official bracket is not
  # "tournament"  - the official bracket is editable, but individual brackets are not; signups disabled
  PHASE = "testing"

  # Database
  MAX_DB_STRING_LENGTH = 254

  # Facebook
  TEST_USER_FB_ID = "707419"
  FB_APP_ACCESS_TOKEN = "505121329539102|Pgu-2aX-nC7Xq3xBHuiztadvNx8"
  FB_APP_ID = "505121329539102"
  FB_APP_SECRET = "305b3e5afc739722934c10e9f4a71815"

  # Restaurants
  RESTAURANTS = {
      "190166997684083" => {
          :id => "190166997684083",
          :name => "Abe's",
          :image => "like_gates/like_gate_abe.png"
      },
      "181834148524304" => {
          :id => "181834148524304",
          :name => "Alcatraz Brewing Co",
          :image => "like_gates/like_gate_alcatraz.png"
      },
      "120870517924902" => {
          :id => "120870517924902",
          :name => "Atlantic Fish",
          :image => "like_gates/like_gate_atlantic.png"
      },
      "347993055268" => {
          :id => "347993055268",
          :name => "Blackhawk Grille",
          :image => "like_gates/like_gate_blackhawk.png"
      },
      "46094964943" => {
          :id => "46094964943",
          :name => "Cafe del Rey",
          :image => "like_gates/like_gate_cafedelrey.png",
      },
      "92945941516" => {
          :id => "92945941516",
          :name => "California Cafe",
          :image => "like_gates/like_gate_california.png",
          :locations => [
              "Los Gatos, CA", # default
              "Palo Alto, CA"
          ]
      },
      "52194381546" => {
          :id => "52194381546",
          :name => "California Cafe",
          :image => "like_gates/like_gate_california.png",
          :locations => [
              "Palo Alto, CA", # default
              "Los Gatos, CA"
          ]
      },
      "265297633509254" => {
      :id => "265297633509254",
      :name => "Joe's American Bar and Grille",
      :image => "like_gates/like_gate_joes.png",
      :locations => [
        "Boston, MA (Newbury)", # default
        "Boston, MA (Waterfront)",
        "Braintree, MA",
        "Dedham, MA",
        "Framingham, MA",
        "Franklin, MA",
        "Peabody, MA",
        "Woburn, MA",
        "Nashua, NH",
        "Providence, RI",
        "Fairfield, CT",
        "Paramus, NJ"
      ]
    },
    "293098704135845" => {
        :id => "293098704135845",
        :name => "Joe's American Bar and Grille",
        :image => "like_gates/like_gate_joes.png",
        :locations => [
            "Paramus, NJ", # default
            "Boston, MA (Newbury)",
            "Boston, MA (Waterfront)",
            "Braintree, MA",
            "Dedham, MA",
            "Framingham, MA",
            "Franklin, MA",
            "Peabody, MA",
            "Woburn, MA",
            "Nashua, NH",
            "Providence, RI",
            "Fairfield, CT"
        ]
    },
    "58761811526" => {
        :id => "58761811526",
        :name => "Napa Valley Grille",
        :image => "like_gates/like_gate_napa.png",
        :locations => [
            "Westwood, CA", # default
            "Bloomington, MN"
        ]
    },
    "171824636186609" => {
      :id => "171824636186609",
      :name => "Napa Valley Grille",
      :image => "like_gates/like_gate_napa.png",
      :locations => [
        "Bloomington, MN", # default
        "Westwood, CA"
      ]
    },
    "309274579106072" => {
        :id => "309274579106072",
        :name => "Papa Razzi Paramus",
        :image => "like_gates/like_gate_papa.png",
    },
    "130416646986919" => {
      :id => "130416646986919",
      :name => "Sapporo",
      :image => "like_gates/like_gate_sapporo.png"
    },
    "71191159109" => {
        :id => "71191159109",
        :name => "Timpano",
        :image => "like_gates/like_gate_timpano.png",
        :locations => [
            "Rockville, MD", # default
            "Fort Lauderdale, FL",
            "Tampa, FL"
        ]
    },
    "92682632632" => {
        :id => "92682632632",
        :name => "Timpano",
        :image => "like_gates/like_gate_timpano.png",
        :locations => [
            "Fort Lauderdale, FL", # default
            "Tampa, FL",
            "Rockville, MD"
        ]
    },
    "79529882826" => {
        :id => "79529882826",
        :name => "Timpano",
        :image => "like_gates/like_gate_timpano.png",
        :locations => [
            "Tampa, FL", # default
            "Fort Lauderdale, FL",
            "Rockville, MD"
        ]
    },
    "41150308569" => {
      :id => "41150308569",
      :name => "ZED451",
      :image => "like_gates/like_gate_zed.png"
    },
    "486859618037849" => {
      :id => "486859618037849",
      :name => "Fake Example Restaurant",
      :image => "like_gates/like_gate_joes.png"
    }
  }

end
