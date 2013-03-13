set :output, "/opt/tavistock-march-madness/log/whenever.log"

every :hour do
  runner "User.update_all_scores"
end
