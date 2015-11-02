class PokerHands

	class << self

		def build *cards
			raise "Invalid hands: Wrong number of cars" if cards.count != 10
			raise "Invalid hands: You cant have two identical cards" if looking_identical_cards(cards)
		end

		private

		def looking_identical_cards *cards
			return (cards.uniq.count != 10)
		end

	end

end

#PokerHands.build("2H","3H","4H","5H","6H","6H","5D","4D","3D","2D")
