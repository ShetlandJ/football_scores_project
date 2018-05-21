require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('../models/tag')
require_relative('../models/vendor')
require_relative('../models/transaction')

# get '/fixtures' do
#   @fixtures = Fixture.all()
#   erb (:result)
# end

get '/fixtures/:home_team/:home_score/:away_score/' do
  @fixtures = Fixture.find_most_recent_result_by_home_team(params[:home_team], params[:home_team_goals], params[:away_team_goals])
  erb ( :result )
end


post '/fixtures/:home_team/:home_score/:away_score/' do
  @fixtures = Fixture.find_most_recent_result_by_home_team(params[:home_team], params[:home_team_goals], params[:away_team_goals])
  erb ( :result )
end

#
# get '/animals/find' do
#   @animals = Animal.find_by_type(params['type'])
#   erb(:"animals/type")
# end
# post '/animals/find' do
#   @animals = Animals.find_by_type(params['type'])
#   erb(:"animals/type")
# end
