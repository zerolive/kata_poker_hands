require './pokerhands'
require 'rspec'

describe "Poker Hands" do

	it "has wrong number of cards" do
		expect{PokerHands.build("")}.to raise_error "Invalid hands: Wrong number of cars"
	end

end