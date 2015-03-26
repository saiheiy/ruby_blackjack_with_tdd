require_relative 'card'
require_relative 'game_state'

class Dealer
    attr_reader :state
    def initialize
        @state = GameState.new
    end

    def print_state
        self.state.print
    end

    def reset_state
        self.state.phase = 0
        self.state.player_cards.clear
        self.state.dealer_cards.clear
        self.state.player_hand_value = nil
        self.state.dealer_hand_value = nil
        self.state.winner = nil
        self.state.bet = nil
    end

    
    def check_in_player(player_funds)
        self.state.player_funds += player_funds
    end

    def deduct_funds_from_player(bet)
        self.state.bet = bet
        self.state.player_funds -= bet
    end

    def deal_cards
        deal(self.state.player_cards)
        deal(self.state.dealer_cards)
    end
    
    def deal(cards_vec)
        2.times do 
            cards_vec << Card.new(rand(1..13), rand(0..3))
        end
    end

    def process_player_action(action)
        if action == :hit
            self.state.player_cards << Card.new(rand(1..13), rand(0..3))
        elsif action == :stay
            self.state.phase = 1
        end
    end

    def update_state_player
        hand_eval = evaluate_cards(self.state.player_cards)
        self.state.player_hand_value = hand_eval
        if self.state.player_cards.length == 2 and hand_eval == 21
            self.state.winner = "player"
            self.state.phase = 2
        elsif hand_eval == 21
            self.state.phase = 1
        elsif evaluate_cards(self.state.player_cards) > 21
            self.state.winner = "dealer"
            self.state.phase = 2 
        end
    end

    def update_state_dealer
        #run only when player has not busted yet
        hand_eval = evaluate_cards(self.state.dealer_cards)
        self.state.dealer_hand_value = hand_eval
        if hand_eval > 21
             self.state.winner = "player"
             self.state.phase = 2
        elsif hand_eval >= 17
            if hand_eval >= self.state.player_hand_value
                self.state.winner = "dealer"
            else
                self.state.winner = "player"
            end
            self.state.phase = 2
        end 
    end

    def evaluate_cards(card_vec)
        poss_results = [0,0]
        card_vec.each do |c|
            if c.rank == 1
                poss_results[0] += 1
                poss_results[1] += 11
            elsif c.rank > 10
                poss_results[0] += 10
                poss_results[1] += 10
            else
                poss_results[0] += c.rank
                poss_results[1] += c.rank
            end
        end
        get_the_best_result(poss_results)
    end

    def get_the_best_result(poss_results)
        if poss_results[0] > poss_results[1]
            bigger = poss_results[0]
            smaller = poss_results[1]
        else
            bigger = poss_results[1]
            smaller = poss_results[0]
        end

        if bigger > 21
            result = smaller
        else
            result = bigger
        end
        result
    end

    def dealer_acts
        self.state.dealer_cards << Card.new(rand(1..13), rand(0..3))
    end

    def player_has_sufficient_funds?
        self.state.player_funds >= 10
    end

    def player_turn?
        self.state.phase == 0
    end

    def dealer_turn?
        self.state.phase == 1 
    end

    def adjust_balance
        if self.state.winner == "player"
            self.state.player_funds += (2*self.state.bet)
        end
    end
end
