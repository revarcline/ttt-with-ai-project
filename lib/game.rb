class Game
  WIN_COMBINATIONS = [
    # horiz
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    # diag
    [0, 4, 8], [6, 4, 2],
    # vert
    [0, 3, 6], [1, 4, 7], [2, 5, 8]
  ].freeze

  attr_accessor :board, :player_1, :player_2

  def initialize(player_1 = Players::Human.new('X'),
                 player_2 = Players::Human.new('O'),
                 board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |wins|
      match_one = @board.cells[wins[0]] == @board.cells[wins[1]]
      match_two = @board.cells[wins[1]] == @board.cells[wins[2]]
      @board.taken?(wins[0] + 1) && match_one && match_two
    end
  end

  def draw?
    !won? && @board.full?
  end

  def over?
    won? || draw?
  end

  def winner
    @board.cells[won?[0]] if won?
  end

  def turn
    player = current_player
    current = player.move(@board)
    turn unless @board.valid_move?(current)

    puts "Turn: #{@board.turn_count}"
    # @board.display
    @board.update(current, player)
    puts "#{player.token} played #{current}"
    @board.display
    puts '=== === ==='
  end

  def play
    turn until over?

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
