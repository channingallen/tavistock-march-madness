set :output, "/opt/tavistock-march-madness/log/whenever.log"

every 1.minutes do
  runner "User.update_all_scores"
end
