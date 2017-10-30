require_relative('Fixture')

File.open('ruby93-94.csv').each do |line|
  tempArray = line.split(',')
  tempHash = {
    "fixture_date" => tempArray[1],
    "home_team" => tempArray[2],
    "away_team" => tempArray[3],
    "home_team_goals" => tempArray[4],
    "away_team_goals" => tempArray[5]
  }
  puts "Fixture.new(#{tempHash}).save"
end
