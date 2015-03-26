class GameState
    attr_accessor :player_funds, :phase, :player_cards, :dealer_cards, :player_hand_value, :dealer_hand_value, :winner, :bet
    def initialize
        @player_funds = 0
        @phase = 0  #0 - player's act, 1 - dealer's act, 2 - winner determined 
        @player_cards = []
        @dealer_cards = []
        @player_hand_value = nil
        @dealer_hand_value = nil
        @winner = nil
        @bet = nil
    end
    
    def print
        system "clear"
        puts "\n"*2
        puts "="*20
        puts "Player funds:  #{self.player_funds}" 
        puts ""
        puts "Dealer's Cards: "
        if self.phase == 0
            puts "( XX ), ( #{self.dealer_cards[1].string_rep} )"
        else
            puts Card.cards_string(self.dealer_cards)
        end
        puts ""
        puts "Player's Cards: "
        puts Card.cards_string(self.player_cards)
        puts ""

        if !self.winner.nil?
            puts "#{self.winner} wins!!"
        end
    end
end

