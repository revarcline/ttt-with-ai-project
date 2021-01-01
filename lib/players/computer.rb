module Players
  # minimax is difficult, i made something beatable
  # maybe some future time i will come back and make it STRONGER
  class Computer < Player
    def move(board)
      free_corners = free_spaces?(board, [1, 3, 7, 9])
      free_sides = free_spaces?(board, [2, 4, 6, 8])

      if !board.taken?(5)
        '5'
      elsif free_corners != []
        free_corners[rand(free_corners.length)]
      elsif free_sides != []
        free_sides[rand(free_sides.length)]
      end
    end

    def free_spaces?(board, cells)
      cells.reject { |cell| board.taken?(cell) }
    end
  end
end
