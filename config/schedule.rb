set :output, "/opt/tavistock-march-madness/log/whenever.log"

every :hour do
  runner "User.update_all_scores"
end

every 1.minute do
  runner "puts \"test\""
end

every :hour do
  runner "User.whenever_test"
end
