# This file should contain all the record creation needed to seed the database
# with its initial data. The data can then be loaded via `rake db:seed`.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create all 347 NCAA Division I teams.
Team.destroy_all
Team.create([
  { :name => "University of Akron" },
  { :name => "University of Alabama" },
  { :name => "Alabama Agricultural and Mechanical University" },
  { :name => "University of Alabama at Birmingham" },
  { :name => "Alabama State University" },
  { :name => "University at Albany, SUNY" },
  { :name => "Alcorn State University" },
  { :name => "American University" },
  { :name => "Appalachian State University" },
  { :name => "University of Arizona" },
  { :name => "Arizona State University" },
  { :name => "University of Arkansas" },
  { :name => "University of Arkansas at Little Rock" },
  { :name => "University of Arkansas at Pine Bluff" },
  { :name => "Arkansas State University" },
  { :name => "Auburn University" },
  { :name => "Austin Peay State University" },
  { :name => "Ball State University" },
  { :name => "Baylor University" },
  { :name => "Belmont University" },
  { :name => "Bethune-Cookman University" },
  { :name => "Binghamton University" },
  { :name => "Boise State University" },
  { :name => "Boston College" },
  { :name => "Boston University" },
  { :name => "Bowling Green State University" },
  { :name => "Bradley University" },
  { :name => "Brigham Young University" },
  { :name => "Brown University" },
  { :name => "Bryant University" },
  { :name => "Bucknell University" },
  { :name => "University at Buffalo, SUNY" },
  { :name => "Butler University" },
  { :name => "University of California, Berkeley" },
  { :name => "University of California, Davis" },
  { :name => "University of California, Irvine" },
  { :name => "University of California, Los Angeles" },
  { :name => "California Polytechnic State University" },
  { :name => "University of California, Riverside" },
  { :name => "University of California, Santa Barbara" },
  { :name => "California State University, Bakersfield" },
  { :name => "California State University, Fresno" },
  { :name => "California State University, Fullerton" },
  { :name => "California State University, Long Beach" },
  { :name => "California State University, Northridge" },
  { :name => "California State University, Sacramento" },
  { :name => "Campbell University" },
  { :name => "Canisius College" },
  { :name => "University of Central Arkansas" },
  { :name => "Central Connecticut State University" },
  { :name => "University of Central Florida" },
  { :name => "Central Michigan University" },
  { :name => "College of Charleston" },
  { :name => "Charleston Southern University" },
  { :name => "Chicago State University" },
  { :name => "University of Cincinnati" },
  { :name => "The Citadel" },
  { :name => "Clemson University" },
  { :name => "Cleveland State University" },
  { :name => "Coastal Carolina University" },
  { :name => "Colgate University" },
  { :name => "University of Colorado at Boulder" },
  { :name => "Colorado State University" },
  { :name => "Columbia University" },
  { :name => "University of Connecticut" },
  { :name => "Coppin State University" },
  { :name => "Cornell University" },
  { :name => "Creighton University" },
  { :name => "Dartmouth College" },
  { :name => "Davidson College" },
  { :name => "University of Dayton" },
  { :name => "University of Delaware" },
  { :name => "Delaware State University" },
  { :name => "University of Denver" },
  { :name => "DePaul University" },
  { :name => "University of Detroit Mercy" },
  { :name => "Drake University" },
  { :name => "Drexel University" },
  { :name => "Duke University" },
  { :name => "Duquesne University" },
  { :name => "East Carolina University" },
  { :name => "East Tennessee State University" },
  { :name => "Eastern Illinois University" },
  { :name => "Eastern Kentucky University" },
  { :name => "Eastern Michigan University" },
  { :name => "Eastern Washington University" },
  { :name => "Elon University" },
  { :name => "University of Evansville" },
  { :name => "Fairfield University" },
  { :name => "Fairleigh Dickinson University" },
  { :name => "University of Florida" },
  { :name => "Florida A&M University" },
  { :name => "Florida Atlantic University" },
  { :name => "Florida Gulf Coast University" },
  { :name => "Florida International University" },
  { :name => "Florida State University" },
  { :name => "Fordham University" },
  { :name => "Furman University" },
  { :name => "Gardner-Webb University" },
  { :name => "George Mason University" },
  { :name => "George Washington University" },
  { :name => "Georgetown University" },
  { :name => "University of Georgia" },
  { :name => "Georgia Institute of Technology" },
  { :name => "Georgia Southern University" },
  { :name => "Georgia State University" },
  { :name => "Gonzaga University" },
  { :name => "Grambling State University" },
  { :name => "Hampton University" },
  { :name => "University of Hartford" },
  { :name => "Harvard University" },
  { :name => "University of Hawai'i at Manoa" },
  { :name => "High Point University" },
  { :name => "Hofstra University" },
  { :name => "College of the Holy Cross" },
  { :name => "University of Houston" },
  { :name => "Houston Baptist University" },
  { :name => "Howard University" },
  { :name => "University of Idaho" },
  { :name => "Idaho State University" },
  { :name => "University of Illinois at Chicago" },
  { :name => "Illinois State University" },
  { :name => "University of Illinois at Urbana-Champaign" },
  { :name => "Indiana State University" },
  { :name => "Indiana University" },
  { :name => "Indiana University - Purdue University Fort Wayne" },
  { :name => "Indiana University - Purdue University Indianapolis" },
  { :name => "Iona College" },
  { :name => "University of Iowa" },
  { :name => "Iowa State University" },
  { :name => "Jackson State University" },
  { :name => "Jacksonville State University" },
  { :name => "Jacksonville University" },
  { :name => "James Madison University" },
  { :name => "University of Kansas" },
  { :name => "Kansas State University" },
  { :name => "Kennesaw State University" },
  { :name => "Kent State University" },
  { :name => "University of Kentucky" },
  { :name => "La Salle University" },
  { :name => "Lafayette College" },
  { :name => "Lamar University" },
  { :name => "Lehigh University" },
  { :name => "Liberty University" },
  { :name => "Lipscomb University" },
  { :name => "Long Island University-Brooklyn" },
  { :name => "Longwood University" },
  { :name => "University of Louisiana at Lafayette" },
  { :name => "University of Louisiana at Monroe" },
  { :name => "Louisiana State University" },
  { :name => "Louisiana Tech University" },
  { :name => "University of Louisville" },
  { :name => "Loyola Marymount University" },
  { :name => "Loyola University Chicago" },
  { :name => "Loyola University Maryland" },
  { :name => "University of Maine" },
  { :name => "Manhattan College" },
  { :name => "Marist College" },
  { :name => "Marquette University" },
  { :name => "Marshall University" },
  { :name => "University of Maryland, Baltimore County" },
  { :name => "University of Maryland, College Park" },
  { :name => "University of Maryland Eastern Shore" },
  { :name => "University of Massachusetts Amherst" },
  { :name => "McNeese State University" },
  { :name => "University of Memphis" },
  { :name => "Mercer University" },
  { :name => "University of Miami" },
  { :name => "Miami University" },
  { :name => "University of Michigan" },
  { :name => "Michigan State University" },
  { :name => "Middle Tennessee State University" },
  { :name => "University of Minnesota" },
  { :name => "University of Mississippi" },
  { :name => "Mississippi State University" },
  { :name => "Mississippi Valley State University" },
  { :name => "University of Missouri" },
  { :name => "University of Missouri-Kansas City" },
  { :name => "Missouri State University" },
  { :name => "Monmouth University" },
  { :name => "University of Montana" },
  { :name => "Montana State University" },
  { :name => "Morehead State University" },
  { :name => "Morgan State University" },
  { :name => "Mount St. Mary's University" },
  { :name => "Murray State University" },
  { :name => "University of Nebraska-Lincoln" },
  { :name => "University of Nebraska at Omaha[A 21]" },
  { :name => "University of Nevada, Las Vegas" },
  { :name => "University of Nevada, Reno" },
  { :name => "University of New Hampshire" },
  { :name => "New Jersey Institute of Technology" },
  { :name => "University of New Mexico" },
  { :name => "New Mexico State University" },
  { :name => "University of New Orleans" },
  { :name => "Niagara University" },
  { :name => "Nicholls State University" },
  { :name => "Norfolk State University" },
  { :name => "North Carolina Agricultural and Technical State University" },
  { :name => "University of North Carolina at Asheville" },
  { :name => "North Carolina Central University" },
  { :name => "University of North Carolina at Chapel Hill" },
  { :name => "University of North Carolina at Charlotte" },
  { :name => "University of North Carolina at Greensboro" },
  { :name => "North Carolina State University" },
  { :name => "University of North Carolina Wilmington" },
  { :name => "University of North Dakota" },
  { :name => "North Dakota State University" },
  { :name => "University of North Florida" },
  { :name => "University of North Texas" },
  { :name => "Northeastern University" },
  { :name => "Northern Arizona University" },
  { :name => "University of Northern Colorado" },
  { :name => "Northern Illinois University" },
  { :name => "University of Northern Iowa" },
  { :name => "Northern Kentucky University[A 24]" },
  { :name => "Northwestern State University" },
  { :name => "Northwestern University" },
  { :name => "University of Notre Dame" },
  { :name => "Oakland University" },
  { :name => "Ohio State University" },
  { :name => "Ohio University" },
  { :name => "University of Oklahoma" },
  { :name => "Oklahoma State University-Stillwater" },
  { :name => "Old Dominion University" },
  { :name => "Oral Roberts University" },
  { :name => "University of Oregon" },
  { :name => "Oregon State University" },
  { :name => "University of the Pacific" },
  { :name => "University of Pennsylvania" },
  { :name => "Pennsylvania State University" },
  { :name => "Pepperdine University" },
  { :name => "University of Pittsburgh" },
  { :name => "University of Portland" },
  { :name => "Portland State University" },
  { :name => "Prairie View A&M University" },
  { :name => "Presbyterian College" },
  { :name => "Princeton University" },
  { :name => "Providence College" },
  { :name => "Purdue University" },
  { :name => "Quinnipiac University" },
  { :name => "Radford University" },
  { :name => "University of Rhode Island" },
  { :name => "Rice University" },
  { :name => "University of Richmond" },
  { :name => "Rider University" },
  { :name => "Robert Morris University" },
  { :name => "Rutgers University" },
  { :name => "Sacred Heart University" },
  { :name => "St. Bonaventure University" },
  { :name => "St. Francis College" },
  { :name => "Saint Francis University" },
  { :name => "St. John's University" },
  { :name => "Saint Joseph's University" },
  { :name => "Saint Louis University" },
  { :name => "Saint Mary's College of California" },
  { :name => "Saint Peter's University" },
  { :name => "Sam Houston State University" },
  { :name => "Samford University" },
  { :name => "University of San Diego" },
  { :name => "San Diego State University" },
  { :name => "University of San Francisco" },
  { :name => "San Jose State University" },
  { :name => "Santa Clara University" },
  { :name => "Savannah State University" },
  { :name => "Seattle University" },
  { :name => "Seton Hall University" },
  { :name => "Siena College" },
  { :name => "University of South Alabama" },
  { :name => "University of South Carolina" },
  { :name => "South Carolina State University" },
  { :name => "University of South Carolina Upstate" },
  { :name => "University of South Dakota" },
  { :name => "South Dakota State University" },
  { :name => "University of South Florida" },
  { :name => "Southeast Missouri State University" },
  { :name => "Southeastern Louisiana University" },
  { :name => "University of Southern California" },
  { :name => "Southern Illinois University Carbondale" },
  { :name => "Southern Illinois University Edwardsville" },
  { :name => "Southern Methodist University" },
  { :name => "University of Southern Mississippi" },
  { :name => "Southern University" },
  { :name => "Southern Utah University" },
  { :name => "Stanford University" },
  { :name => "Stephen F. Austin State University" },
  { :name => "Stetson University" },
  { :name => "Stony Brook University" },
  { :name => "Syracuse University" },
  { :name => "Temple University" },
  { :name => "University of Tennessee" },
  { :name => "University of Tennessee at Chattanooga" },
  { :name => "University of Tennessee at Martin" },
  { :name => "Tennessee State University" },
  { :name => "Tennessee Technological University" },
  { :name => "Texas A&M University" },
  { :name => "Texas A&M University-Corpus Christi" },
  { :name => "University of Texas at Arlington" },
  { :name => "University of Texas at Austin" },
  { :name => "Texas Christian University" },
  { :name => "University of Texas at El Paso" },
  { :name => "University of Texas-Pan American" },
  { :name => "University of Texas at San Antonio" },
  { :name => "Texas Southern University" },
  { :name => "Texas State University-San Marcos" },
  { :name => "Texas Tech University" },
  { :name => "University of Toledo" },
  { :name => "Towson University" },
  { :name => "Troy University" },
  { :name => "Tulane University" },
  { :name => "University of Tulsa" },
  { :name => "United States Air Force Academy" },
  { :name => "United States Military Academy" },
  { :name => "United States Naval Academy" },
  { :name => "University of Utah" },
  { :name => "Utah State University" },
  { :name => "Utah Valley University" },
  { :name => "Valparaiso University" },
  { :name => "Vanderbilt University" },
  { :name => "University of Vermont" },
  { :name => "Villanova University" },
  { :name => "University of Virginia" },
  { :name => "Virginia Commonwealth University" },
  { :name => "Virginia Military Institute" },
  { :name => "Virginia Tech" },
  { :name => "Wagner College" },
  { :name => "Wake Forest University" },
  { :name => "University of Washington" },
  { :name => "Washington State University" },
  { :name => "Weber State University" },
  { :name => "West Virginia University" },
  { :name => "Western Carolina University" },
  { :name => "Western Illinois University" },
  { :name => "Western Kentucky University" },
  { :name => "Western Michigan University" },
  { :name => "Wichita State University" },
  { :name => "College of William & Mary" },
  { :name => "Winthrop University" },
  { :name => "University of Wisconsin-Green Bay" },
  { :name => "University of Wisconsin-Madison" },
  { :name => "University of Wisconsin-Milwaukee" },
  { :name => "Wofford College" },
  { :name => "Wright State University" },
  { :name => "University of Wyoming" },
  { :name => "Xavier University" },
  { :name => "Yale University" },
  { :name => "Youngstown State University" }
])

# Create the official bracket.
Bracket.create({ :is_official => true })

# Create some dummy users.
# TODO: Delete this code. We don't want any dummy users on the actual server.
i = 0
User.destroy_all
User.create([
  { :name => "Courtland Allen", :email => "asdf#{i += 1}@example.com" },
  { :name => "Philip Garcia", :email => "asdf#{i += 1}@example.com" },
  { :name => "Aaron Rosado", :email => "asdf#{i += 1}@example.com" },
  { :name => "Adrian Adames", :email => "asdf#{i += 1}@example.com" },
  { :name => "Antoinne Machal-Cajigas", :email => "asdf#{i += 1}@example.com" },
  { :name => "Carlos Ilizaliturri", :email => "asdf#{i += 1}@example.com" },
  { :name => "Steve Nunez", :email => "asdf#{i += 1}@example.com" },
  { :name => "Geraldine Lim", :email => "asdf#{i += 1}@example.com" },
  { :name => "Susan Hessenthaler", :email => "asdf#{i += 1}@example.com" },
  { :name => "Channing Allen", :email => "asdf#{i += 1}@example.com" },
  { :name => "Eva Allen", :email => "asdf#{i += 1}@example.com" },
  { :name => "Michael Kim", :email => "asdf#{i += 1}@example.com" },
  { :name => "Cristian Derr", :email => "asdf#{i += 1}@example.com" },
  { :name => "Phillip Pinto", :email => "asdf#{i += 1}@example.com" },
  { :name => "Tyco Skinner", :email => "asdf#{i += 1}@example.com" }
])