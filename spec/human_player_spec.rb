require 'spec_helper'
require 'human_player'

describe HumanPlayer do 
    let(:human_player) { described_class.new(1000) }

    describe "#make_action" do
        it "returns :hit or :stay when user (eventually) inputs hit or stay" do
            @hp = HumanPlayer.new(1000)
            allow(@hp).to receive(:gets).and_return("hit\n", "stay\n", "bla\n", "hit\n")
            expect(@hp.make_action).to eql(:hit)
            expect(@hp.make_action).to eql(:stay)
            expect(@hp.make_action).to eql(:hit)
        end
    end
end
