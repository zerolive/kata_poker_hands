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
		expect(PokerHands.build(["2c","3c","4c","5H","9h","6H","5c","4D","3D","8D"])).to eq("Black player wins with the highest card")
		expect(PokerHands.build(["2c","3c","4c","5H","7h","aH","5c","4D","3D","2D"])).to eq("White player wins with the highest card")
		expect(PokerHands.build(["3c", "5d", "6h", "7s", "8c", "2d", "5h", "6s", "7c", "8d"])).to eq("Black player wins with the highest card")
		expect(PokerHands.build(["2c", "5d", "6h", "7s", "8c", "3d", "5h", "6s", "7c", "8d"])).to eq("White player wins with the highest card")
		expect(PokerHands.build(["3c", "5d", "6h", "7s", "8c", "3d", "5h", "6s", "7c", "8d"])).to eq("Tie with the highest card")
	end

	it "knows who win with pair, highest pair and tie" do
		expect(PokerHands.build(["2c","3c","4c","2H","7h","7c","5c","4D","3D","2D"])).to eq("Black player wins with Pair")
		expect(PokerHands.build(["2c","3c","4c","5H","7s","7h","7c","4D","3D","2D"])).to eq("White player wins with Pair")
		expect(PokerHands.build(["2c","3c","5c","5H","7h","6c","4c","4D","3D","2D"])).to eq("Black player wins with the highest Pair")
		expect(PokerHands.build(["2c","3c","5c","5H","7h","6c","6d","4D","3D","2D"])).to eq("White player wins with the highest Pair")
		expect(PokerHands.build(["2c","3c","4c","7s","7h","7c","7d","4D","3D","2D"])).to eq("Tie with Pair")
	end

	it "knows who win with pairs, highest pairs and tie" do
		expect(PokerHands.build(["2c","2d","3h","3s","4c","4d","5h","6s","7c","9d"])).to eq("Black player wins with Pairs")
		expect(PokerHands.build(["2c","3d","4h","5s","7c","6d","7h","7s","8c","8d"])).to eq("White player wins with Pairs")
		expect(PokerHands.build(["6c","6d","5h","5s","4c","4d","3h","3s","2c","2d"])).to eq("Black player wins with the highest Pairs")
		expect(PokerHands.build(["2c","2d","3h","3s","4c","4d","5h","5s","6c","6d"])).to eq("White player wins with the highest Pairs")
		expect(PokerHands.build(["6c","6d","5h","5s","4c","4d","6h","6s","5c","5d"])).to eq("Tie with Pairs")
	end

	it "knows who win with three of a kind and highest three of a kind" do
		expect(PokerHands.build(["2c","2d","2h","5s","6c","6d","7h","8s","9c","Ad"])).to eq("Black player wins with three of a kind")
		expect(PokerHands.build(["2c","3d","4h","8s","6c","6d","7h","9s","9c","9d"])).to eq("White player wins with three of a kind")
		expect(PokerHands.build(["9c","9d","9h","5s","6c","6d","7h","8s","8c","8d"])).to eq("Black player wins with the highest three of a kind")
		expect(PokerHands.build(["2c","2d","2h","5s","6c","6d","7h","9s","9c","9d"])).to eq("White player wins with the highest three of a kind")
	end

	it "knows who win with straight, highest straight and tie" do
		expect(PokerHands.build(["2c","3d","4h","5s","6c","6d","2h","8s","9c","Ad"])).to eq("Black player wins with straight")
		expect(PokerHands.build(["2c","2d","4h","5s","6c","5d","6h","7s","8c","9d"])).to eq("White player wins with straight")
		expect(PokerHands.build(["3c","4d","5h","6s","7c","2d","3h","4s","5c","6d"])).to eq("Black player wins with the highest straight")
		expect(PokerHands.build(["2c","3d","4h","5s","6c","7d","6h","5h","4c","3h"])).to eq("White player wins with the highest straight")
		expect(PokerHands.build(["2c","3d","4h","5s","6c","6d","5h","4s","3c","2d"])).to eq("Tie with straight")
	end

	it "knows who win with flush, highest flush and tie" do
		expect(PokerHands.build(["2c","4c","5c","6c","7c","6d","2h","8s","9c","Ad"])).to eq("Black player wins with flush")
		expect(PokerHands.build(["6d","2h","8s","9c","Ad","2c","4c","5c","6c","7c"])).to eq("White player wins with flush")
		expect(PokerHands.build(["2c","4c","5c","6c","7c","3d","2d","5d","6d","7d"])).to eq("Black player wins with the highest flush")
		expect(PokerHands.build(["3d","2d","5d","6d","7d","2c","4c","5c","6c","7c"])).to eq("White player wins with the highest flush")
		expect(PokerHands.build(["3d","4d","9d","6d","7d","3c","4c","9c","6c","7c"])).to eq("Tie with flush")
	end

	it "knows who win with full house and the highest full house" do
		expect(PokerHands.build(["3s","3c","2c","2d","2h","6d","3h","8s","9c","Ad"])).to eq("Black player wins with full house")
		expect(PokerHands.build(["6d","3h","8s","9c","Ad","2c","2d","2h","3s","3c"])).to eq("White player wins with full house")
		expect(PokerHands.build(["4d","4h","4s","5c","5d","2c","2d","2h","3s","3c"])).to eq("Black player wins with the highest full house")
		expect(PokerHands.build(["2c","2d","2h","3s","3c","4d","4h","4s","5c","5d"])).to eq("White player wins with the highest full house")
	end

	it "knows who win with four of a kind and highest four of a kind" do
		expect(PokerHands.build(["2c","2d","2h","2s","6c","6d","7h","8s","9c","Ad"])).to eq("Black player wins with four of a kind")
		expect(PokerHands.build(["2c","3d","4h","8s","6c","6d","9h","9s","9c","9d"])).to eq("White player wins with four of a kind")
		expect(PokerHands.build(["9c","9d","9h","9s","6c","6d","8h","8s","8c","8d"])).to eq("Black player wins with the highest four of a kind")
		expect(PokerHands.build(["2c","2d","2h","2s","6c","6d","9h","9s","9c","9d"])).to eq("White player wins with the highest four of a kind")
	end

	it "knows who win with straight flush, highest straight flush and tie" do
		expect(PokerHands.build(["2c","3c","4c","5c","6c","6d","2h","8s","9c","Ad"])).to eq("Black player wins with straight flush")
		expect(PokerHands.build(["2c","2d","4h","5s","6c","5d","6d","7d","8d","9d"])).to eq("White player wins with straight flush")
		expect(PokerHands.build(["5d","6d","7d","8d","9d","2c","3c","4c","5c","6c"])).to eq("Black player wins with the highest straight flush")
		expect(PokerHands.build(["2c","3c","4c","5c","6c","5d","6d","7d","8d","9d"])).to eq("White player wins with the highest straight flush")
		expect(PokerHands.build(["5c","6c","7c","8c","9c","5d","6d","7d","8d","9d"])).to eq("Tie with straight flush")
	end
end