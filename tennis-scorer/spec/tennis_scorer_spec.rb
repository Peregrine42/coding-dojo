require_relative "../lib/tennis_scorer"
require_relative "spec_helper"

describe TennisScorer do
  it "makes the score LOVE ALL at the start of a game" do
    s = TennisScorer.new
    expect(s.score).to eq "LOVE ALL"
  end

  it "makes the score 15-LOVE when the first player scores" do
    s = TennisScorer.new
    s.player_1_scores
    expect(s.score).to eq "15-LOVE"
  end

  it "makes the score 30-LOVE when the first player scores twice" do
    s = TennisScorer.new
    2.times do
      s.player_1_scores
    end
    expect(s.score).to eq "30-LOVE"
  end

  it "makes the score LOVE-15 when the second player scores" do
    s = TennisScorer.new
    s.player_2_scores
    expect(s.score).to eq "LOVE-15"
  end

  it "makes the score LOVE-30 when the second player scores twice" do
    s = TennisScorer.new
    2.times do
      s.player_2_scores
    end
    expect(s.score).to eq "LOVE-30"
  end

  it "makes the score 15 ALL when each player has scored once" do
    s = TennisScorer.new
    s.player_1_scores
    s.player_2_scores

    expect(s.score).to eq "15 ALL"
  end

  it "player 1 wins when he has scored more than 40 points and p2 has not scored" do
    s = TennisScorer.new
    4.times do
      s.player_1_scores
    end

    expect(s.score).to eq "PLAYER 1 WINS"
  end

  it "player 1 does't win when he has scored more than 40 points but p2 has scored 40 points" do
    s = TennisScorer.new

    3.times do
      s.player_2_scores
    end

    4.times do
      s.player_1_scores
    end

    expect(s.score).to eq "GAME POINT PLAYER 1"
  end

  it "player 1 wins when he has scored more than 40 points and p2 has scored 30 points" do
    s = TennisScorer.new

    2.times do
      s.player_2_scores
    end

    4.times do
      s.player_1_scores
    end

    expect(s.score).to eq "PLAYER 1 WINS"
  end

  it "player 2 wins when he has scored more than 40 points and p1 has not scored" do
    s = TennisScorer.new
    4.times do
      s.player_2_scores
    end

    expect(s.score).to eq "PLAYER 2 WINS"
  end

  it "player 2 does't win when he has scored more than 40 points but p1 has scored 40 points" do
    s = TennisScorer.new

    3.times do
      s.player_1_scores
    end

    4.times do
      s.player_2_scores
    end

    expect(s.score).to eq "GAME POINT PLAYER 2"
  end

  it "player 2 wins when he has scored more than 40 points and p1 has scored 30 points" do
    s = TennisScorer.new

    2.times do
      s.player_1_scores
    end

    4.times do
      s.player_2_scores
    end

    expect(s.score).to eq "PLAYER 2 WINS"
  end

  it "return DEUCE if both players score is equal and both players have a score of 40 or more" do
    s = TennisScorer.new

    3.times do
      s.player_1_scores
      s.player_2_scores
    end

    expect(s.score).to eq "DEUCE"

  end

  it "returns GAME POINT PLAYER 1 if both player have scored at least three points and player 1 is one point ahead" do

    s = TennisScorer.new

    3.times do
      s.player_1_scores
      s.player_2_scores
    end

    s.player_1_scores

    expect(s.score).to eq "GAME POINT PLAYER 1"
  end

  it "returns GAME POINT PLAYER 2 if both player have scored at least three points and player 2 is one point ahead" do

    s = TennisScorer.new

    3.times do
      s.player_1_scores
      s.player_2_scores
    end

    s.player_2_scores

    expect(s.score).to eq "GAME POINT PLAYER 2"
  end

  it "returns 2 GAME POINTS PLAYER 1 if the score is 40-15" do
    s = TennisScorer.new

    3.times do
      s.player_1_scores
    end

    s.player_2_scores

    expect(s.score).to eq "2 GAME POINTS PLAYER 1"
  end

  it "returns 2 GAME POINTS PLAYER 2 if the score is 15-40" do
    s = TennisScorer.new

    3.times do
      s.player_2_scores
    end

    s.player_1_scores

    expect(s.score).to eq "2 GAME POINTS PLAYER 2"
  end

  it "returns 3 GAME POINTS PLAYER 1 if the score is 40-0" do
    s = TennisScorer.new

    3.times do
      s.player_1_scores
    end

    expect(s.score).to eq "3 GAME POINTS PLAYER 1"
  end

  it "returns 3 GAME POINTS PLAYER 2 if the score is 0-40" do
    s = TennisScorer.new

    3.times do
      s.player_2_scores
    end

    expect(s.score).to eq "3 GAME POINTS PLAYER 2"
  end

  it "returns GAME, SET, PLAYER 1 when player 1 has won 6 games and is two games ahead" do
    s = TennisScorer.new

    5.times do
      4.times do
        s.player_2_scores
      end
    end
    7.times do
      4.times do
        s.player_1_scores
      end
    end

    expect(s.score).to eq "GAME, SET, PLAYER 1"

  end

  it "returns GAME, SET, MATCH PLAYER 1 when player 1 has won 2 sets" do
    $s = TennisScorer.new
    def win_set
      6.times do
        4.times do
          $s.player_1_scores
        end
      end
    end
    win_set
    win_set

    expect($s.score).to eq "GAME, SET, MATCH, PLAYER 1"
  end
end
