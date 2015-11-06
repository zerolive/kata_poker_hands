class PokerHands

	RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"]
	SUITS = ["C", "D", "H", "S"]
	CARDSINHANDS = 10
	CARDCHARS = 2

	class << self

		def build *hands
			hands = hands.map(&:upcase)
			raise "Invalid hands: Wrong number of cars" unless have_ten_card *hands
			raise "Invalid hands: Some card is invalid" unless spelling_is_right *hands
			raise "Invalid hands: You cant have identical cards" unless have_some_repeated_card *hands
			raise "Invalid hands: Some card doesnt exist" unless exist_some_card *hands
		end

		private

			def exist_some_card *hands 
				hands.each do |card|
					return false unless RANKS.include?(card[0]) & SUITS.include?(card[1])
				end
			end

			def have_some_repeated_card *hands
				return hands.uniq.count == CARDSINHANDS
			end

			def spelling_is_right *hands
				hands.each do |card|
 					return false unless card_has_two_characters(card)
 				end
			end

			def card_has_two_characters card
				return card.length == CARDCHARS
			end

			def have_ten_card *hands
				return hands.count == CARDSINHANDS
			end
	end

end

#	RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"]
#	SUITS = ["C", "D", "H", "S"]
PokerHands.build("2H","3H","4H","5H","7H","6H","5d","4D","3D","2D")
