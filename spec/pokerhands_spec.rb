require './pokerhands'
require 'rspec'

describe "Poker Hands" do

	it "has wrong number of cards" do
		expect{PokerHands.build(["2D"])}.to raise_error "Invalid hands: Wrong number of cars"
		expect{PokerHands.build(["2H","3H","4H","5H","7H","6H","5D","4D","3D"])}.to raise_error "Invalid hands: Wrong number of cars"
		expect{PokerHands.build(["2H","3H","4H","5H","7H","6H","5D","4D","3D","2D"])}.to_not raise_error
	end

	it "has two identical cards" do
		expect{PokerHands.build(["2H","3H","4H","5H","6H","6H","5D","4D","3D","2D"])}.to raise_error "Invalid hands: You cant have identical cards"
		expect{PokerHands.build(["2H","3H","4H","5H","7H","6H","5D","4D","3D","2D"])}.to_not raise_error
	end

	it "has some invalid card" do
		expect{PokerHands.build(["2H","3H","4H","5H","7H","6H","5D","4D","3D","22D"])}.to raise_error "Invalid hands: Some card is invalid"
		expect{PokerHands.build(["2H","3H","4H","5H","7H","6H","5D","4D","3D","D"])}.to raise_error "Invalid hands: Some card is invalid"
		expect{PokerHands.build(["2H","3H","4H","5H","7H","6H","5D","4D","3D","2D"])}.to_not raise_error
	end

	it "has some wrong card" do
		expect{PokerHands.build(["2H","3H","4h","5H","7H","6H","5D","4D","3D","2A"])}.to raise_error "Invalid hands: Some card doesnt exist"
		expect{PokerHands.build(["2H","3H","4H","5h","7H","6H","5D","4D","3D","DD"])}.to raise_error "Invalid hands: Some card doesnt exist"
		expect{PokerHands.build(["2H","3H","4H","5H","7h","6H","5D","4D","3D","2D"])}.to_not raise_error
	end

	it "knows who wins with highest card and tie" do
		expect(PokerHands.build(["2c","3c","4c","5H","9h","6H","5c","4D","3D","2D"])).to eq("Black player wins with the highest card")
		expect(PokerHands.build(["2c","3c","4c","5H","6h","aH","5c","4D","3D","2D"])).to eq("White player wins with the highest card")
		expect(PokerHands.build(["2c","3c","4c","5H","7h","7c","5c","4D","3D","2D"])).to eq("Tie with the highest card")
	end

	it "knows who win with pair, highest pair and tie" do
		expect(PokerHands.build(["2c","3c","4c","2H","7h","7c","5c","4D","3D","2D"])).to eq("Black player wins with Pair")
		expect(PokerHands.build(["2c","3c","4c","5H","7s","7h","7c","4D","3D","2D"])).to eq("White player wins with Pair")
		expect(PokerHands.build(["2c","3c","5c","5H","7h","6c","4c","4D","3D","2D"])).to eq("Black player wins with the highest Pair")
		expect(PokerHands.build(["2c","3c","5c","5H","7h","6c","6d","4D","3D","2D"])).to eq("White player wins with the highest Pair")
		expect(PokerHands.build(["2c","3c","4c","7s","7h","7c","7d","4D","3D","2D"])).to eq("Tie with Pair")
	end

	it "knows who win with pairs, highest pairs and tie" do
		expect(PokerHands.build(["2c","2d","3h","3s","4c","4d","5h","6s","7c","8d"])).to eq("Black player wins with Pairs")
		expect(PokerHands.build(["2c","3d","4h","5s","6c","6d","7h","7s","8c","8d"])).to eq("White player wins with Pairs")
		expect(PokerHands.build(["6c","6d","5h","5s","4c","4d","3h","3s","2c","2d"])).to eq("Black player wins with the highest Pairs")
		expect(PokerHands.build(["2c","2d","3h","3s","4c","4d","5h","5s","6c","6d"])).to eq("White player wins with the highest Pairs")
		expect(PokerHands.build(["6c","6d","5h","5s","4c","4d","6h","6s","5c","5d"])).to eq("Tie with Pairs")
	end
end