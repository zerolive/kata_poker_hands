require './pokerhands'
require 'rspec'

describe "Poker Hands" do

	it "has wrong number of cards" do
		expect{PokerHands.build("")}.to raise_error "Invalid hands: Wrong number of cars"
	end

	it "has two identical cards" do
		expect{PokerHands.build("2H","3H","4H","5H","6H","6H","5D","4D","3D","2D")}.to raise_error "Invalid hands: You cant have two identical cards"
	end

	it "has some invalid card" do
		expect{PokerHands.build("2H","3H","4H","5H","7H","6H","5D","4D","3D","22D")}.to raise_error "Invalid hands: Some card is invalid"
	end
end