class GameRunner
    attr_reader :dealer, :player, :min_bet
    def initialize(dealer, player)
         @dealer = dealer
         @player = player
         @min_bet = 10
    end

    def run
        self.dealer.check_in_player(self.player.funds)
        while self.dealer.player_has_sufficient_funds?
            self.dealer.reset_state
            self.dealer.deduct_funds_from_player(self.min_bet)
            self.dealer.deal_cards
            self.dealer.update_state_player
            self.dealer.print_state 

            player_acts
            dealer_acts

            self.dealer.print_state
            self.dealer.adjust_balance
            self.dealer.print_state
           
            puts "\npress any key to continue" 
            _ = gets

        end
    end

    def player_acts
        while self.dealer.player_turn?
            action = self.player.make_action
            self.dealer.process_player_action(action)
            self.dealer.update_state_player
            self.dealer.print_state
        end
    end

    def dealer_acts
        self.dealer.update_state_dealer
        while self.dealer.dealer_turn?
            self.dealer.dealer_acts
            self.dealer.update_state_dealer
        end
    end
end
