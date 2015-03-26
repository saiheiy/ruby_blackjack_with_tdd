class HumanPlayer
    attr_reader :funds
    
    def initialize(initial_funds)
        @funds = initial_funds
    end
    
    def make_action
        while true
            puts "hit or stay?"
            action = gets.chomp
            if action == "hit"
                return :hit
            elsif action == "stay"
                return :stay
            else
                puts "incorrect input try again"
            end
        end
    end
end
