class PokerHands

	CARDSINHAND = 10

	class << self

		def build *cards
			raise "Invalid hands: Wrong number of cars" if cards.count != CARDSINHAND
			raise "Invalid hands: You cant have two identical cards" if looking_identical_cards(*cards)
			raise "Invalid hands: Some card is invalid" if check_spelling(*cards)
		end

		private

			def looking_identical_cards *cards
				return (cards.uniq.count != CARDSINHAND)
			end

			def check_spelling *cards
				cards.each do |card|
 					if !card.slice(2).nil?
 						return true
 					end
 				end
 				return false
			end
	end

end

# C, D, H, S
# A, 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K
#PokerHands.build("2H","3H","4H","5H","7H","6H","5D","4D","3D","22D")
