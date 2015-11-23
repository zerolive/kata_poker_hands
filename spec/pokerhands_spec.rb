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

	it "knows black's ranks" do
		expect(BlackHand.ranks(["2c","3c","4c","5H","9h","6H","5c","4D","3D","8D"])).to eq([0,1,2,3,7])
	end
end