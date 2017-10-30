require_relative('../db/sql_runner')
# require_relative('file_loop')

require('date')

class Fixture

  attr_accessor :fixture_date, :home_team, :away_team, :home_team_goals, :away_team_goals
  attr_reader :id

  def initialize( options )
    @id = options['id'].to_i
    @fixture_date = options['fixture_date']
    @home_team = options['home_team']
    @away_team = options['away_team']
    @home_team_goals = options['home_team_goals'].to_i
    @away_team_goals = options['away_team_goals'].to_i
  end

  def save()
    sql = "INSERT INTO fixtures
    (
      fixture_date,
      home_team,
      away_team,
      home_team_goals,
      away_team_goals
    )
    VALUES
    (
      $1, $2, $3, $4, $5
    )
    RETURNING *"
    values = [@fixture_date, @home_team, @away_team, @home_team_goals, @away_team_goals]
    transaction_data = SqlRunner.run(sql, values)
    @id = transaction_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE fixtures
    SET
    (
      fixture_date,
      home_team,
      away_team,
      home_team_goals,
      away_team_goals
      ) =
      (
        $1, $2, $3, $4, $5
      )
      WHERE id = $6"
      values = [@fixture_date, @home_team, @away_team, @home_team_goals, @away_team_goals, @id]
      SqlRunner.run( sql, values )
    end

    def delete()
      sql = "DELETE FROM fixtures
      WHERE id = $1"
      values = [@id]
      SqlRunner.run( sql, values )
    end

    def self.delete_all()
      sql = "DELETE FROM fixtures"
      values = []
      SqlRunner.run( sql, values )
    end

    def self.all()
      sql = "SELECT * FROM fixtures;"
      values = []
      fixtures = SqlRunner.run( sql, values )
      return fixtures.map { |fixture| Fixture.new( fixture ) }
    end

    def self.find( id )
      sql = "SELECT * FROM fixtures WHERE id = $1"
      values = [id]
      fixtures = SqlRunner.run( sql, values )
      result = Fixture.new( fixtures.first )
      return result
    end

    def self.find_by_home_team( home_team )
      sql = "SELECT * FROM fixtures WHERE home_team = $1"
      values = [home_team]
      fixtures = SqlRunner.run( sql, values )
      result = Fixture.new( fixtures.first )
      return result
    end

    def self.find_by_result( home_score, away_score )
      sql = "SELECT * FROM fixtures WHERE home_team_goals = $1 AND away_team_goals = $2"
      values = [@home_team_goals, @away_team_goals]
      fixtures = SqlRunner.run( sql, values )
      result = Fixture.new( fixtures.first )
      return result
    end

    def self.find_by_result( home_score, away_score )
      sql = "SELECT * FROM fixtures WHERE home_team_goals = $1 AND away_team_goals = $2"
      values = [@home_team_goals, @away_team_goals]
      fixtures = SqlRunner.run( sql, values )
      return fixtures.map { |fixture| Fixture.new( fixture ) }
    end

    def self.find_all_results_by_home_team_by_score( home_team, home_score, away_score )
      sql = "SELECT * FROM fixtures WHERE home_team = $1 AND home_team_goals = $2 AND away_team_goals = $3 ORDER BY fixture_date DESC"
      values = [@home_team, @home_team_goals, @away_team_goals]
      fixtures = SqlRunner.run( sql, values )
      return fixtures.map { |fixture| Fixture.new( fixture ) }
    end

    def self.find_all_results_by_away_team_by_score( away_team, home_score, away_score )
      sql = "SELECT * FROM fixtures WHERE home_team = $1 AND home_team_goals = $2 AND away_team_goals = $3 ORDER BY fixture_date"
      values = [@home_team, @home_team_goals, @away_team_goals]
      fixtures = SqlRunner.run( sql, values )
      return fixtures.map { |fixture| Fixture.new( fixture ) }
    end

    def self.find_most_recent_result_by_home_team( home_team, home_score, away_score )
      sql = "SELECT * FROM fixtures WHERE home_team = $1 AND home_team_goals = $2 AND away_team_goals = $3 ORDER BY fixture_date DESC LIMIT 1"
      values = [@home_team, @home_team_goals, @away_team_goals]
      fixtures = SqlRunner.run( sql, values )
      return fixtures
    end

    def self.find_most_recent_result_by_away_team( away_team, home_score, away_score )
      sql = "SELECT * FROM fixtures WHERE away_team = $1 AND home_team_goals = $2 AND away_team_goals = $3 ORDER BY fixture_date DESC LIMIT 1"
      values = [@away_team, @home_team_goals, @away_team_goals]
      fixtures = SqlRunner.run( sql, values )
      return fixtures
    end

end
