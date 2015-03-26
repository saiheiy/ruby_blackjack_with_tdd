class Card
    attr_reader :rank, :suit, :string_rep
    @@card_rank = "_A23456789TJQK".freeze
    @@card_suit = "DCHS".freeze
    def initialize(rank, suit)
        @rank = rank
        @suit = suit
        @string_rep = @@card_rank[@rank] + @@card_suit[@suit]
    end

    def self.cards_string(cards_vec)
        cards_str = ""
        cards_vec.each do |c|
            cards_str += "( #{c.string_rep} ), "
        end
        cards_str
    end
end
