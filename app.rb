require('sinatra')
require('sinatra/contrib/all')
require('date')

require_relative('./models/Fixture')
# require_relative('./controllers/fixtures_controller')

get '/' do
  @teams = Fixture.all_teams()
  @home_score = Fixture.get_home_goals()
  @away_score = Fixture.get_away_goals()
  erb ( :home )
end

# @month = Transaction.by_date(params[:year], params[:month])
# @months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
# @most_common_tag_per_month = Transaction.most_common_tag_per_month( Date.today.month )
