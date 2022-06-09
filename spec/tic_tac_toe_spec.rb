require './lib/tic_tac_toe'

RSpec.describe TicTacToe do
  describe '#input_to_board' do
    it 'returns current player if play is valid' do
      game = TicTacToe.new('Bruno', 'Giu')
      expect(game.input_to_board(1, 1)).to eq('Giu')
    end
    
    it 'returns nil if play is not valid' do
      game = TicTacToe.new('Bruno', 'Giu')
      expect(game.input_to_board(4, 1)).to_not eq('Giu')
    end
  end
  
  describe '#current_player' do
    it 'returns player 1 if no one has played' do
      player1 = 'Bruno'
      game = TicTacToe.new(player1, 'Giu')
      expect(game.current_player).to be(player1) 
    end
  end
  
  describe '#display_the_board' do
    it 'display an empty board' do
      game = TicTacToe.new('Bruno', 'Giu')
      empty_board = "\nColumn     1   2   3\n"\
                    "Row    1 [   |   |   ]\n"\
                    "Row    2 [   |   |   ]\n"\
                    "Row    3 [   |   |   ]\n"
      expect(game.display_the_board).to eq(empty_board)
    end

    it 'display game, after two moves' do
      game = TicTacToe.new('Bruno', 'Giu')
      game.input_to_board(1, 1)
      game.input_to_board(2, 2)
      board = "\nColumn     1   2   3\n"\
                    "Row    1 [ X |   |   ]\n"\
                    "Row    2 [   | O |   ]\n"\
                    "Row    3 [   |   |   ]\n"
      expect(game.display_the_board).to eq(board)
    end
  end
end
