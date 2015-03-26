require_relative 'game_runner'
require_relative 'human_player'
require_relative 'dealer'

dealer = Dealer.new
player = HumanPlayer.new(1000)
gr = GameRunner.new(dealer, player)
gr.run
