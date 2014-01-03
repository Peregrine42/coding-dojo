class TennisScorer

  class Player
  
    attr_accessor :points, :name, :games_won, :sets_won

    def initialize name
      @name = name
      @points = 0
      @games_won = 0
      @sets_won = 0
      @start_of_game = true
      @start_of_set = true
    end

  end

  def initialize
    @players = [Player.new("PLAYER 1"), Player.new("PLAYER 2")]

    @scoring_system = {0 => "LOVE",
                       1 => "15",
                       2 => "30",
                       3 => "40"}
  end

  def player_1_scores
    player_scores 0
  end

  def player_2_scores
    player_scores 1
  end

  def player_scores index
    if @start_of_game
      @players[0].points = 0
      @players[1].points = 0
      @start_of_game = false
    end

    if @start_of_set
      @players[0].games_won = 0
      @players[1].games_won = 0
      @start_of_set = false
    end

    @players[index].points += 1
    if score().match(/WINS/)
      leader, loser = sort_by_points
      leader.games_won += 1
      if leader.games_won > 5 and leader.games_won > loser.games_won + 1
        leader.sets_won += 1
        @start_of_set = true
      end
      @start_of_game = true

    end
  end

  def sort_by_points
    return [@players[0], @players[1]] if @players[0].points > @players[1].points
    return [@players[1], @players[0]] if @players[1].points > @players[0].points
    return [@players[0], @players[1]]
  end

  def score
    # check for draw
    if @players[0].points == @players[1].points 
      return "DEUCE" if @players[0].points >= 3
      return "#{@scoring_system[@players[0].points]} ALL" 
    end

    # find the leader
    leader, loser = sort_by_points

    # leader could win
    if leader.points > 3

      # leader wins if clear by 2 points
      if leader.points > loser.points + 1
        if leader.games_won > 5 and leader.games_won > loser.games_won + 1
          if leader.sets_won >= 2
            return "GAME, SET, MATCH, #{leader.name}"
          end
          return "GAME, SET, #{leader.name}"
        end
        return "#{leader.name} WINS"
      end

      # if leader still hasn't won, then we must be at advantage leader
      return "GAME POINT #{leader.name}"
    end

    # handle other game points
    scoreDiff = leader.points - loser.points
    return "#{scoreDiff} GAME POINTS #{leader.name}" if leader.points == 3

    # if we have got this far then all special cases are done and we just
    # return the score
    "#{@scoring_system[@players[0].points]}-#{@scoring_system[@players[1].points]}"
  end
end
