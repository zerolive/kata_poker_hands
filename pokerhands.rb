class PokerHands

	class << self

		def build hands
			hands = hands.map(&:upcase)

			RaiseInvalidHands.build hands
		end

	end

end

class Deck

	RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
	SUITS = ["C", "D", "H", "S"]

	class << self

		def ranks
			RANKS
		end

		def suits
			SUITS
		end

	end
end

class RaiseInvalidHands
	
	CARDS_IN_HANDS = 10
	CARDS_CHARACTERS = 2
	INVALIDHANDS = "Invalid hands:"

	class << self

		def build hands
			raise "#{INVALIDHANDS} Wrong number of cars" unless have_ten_card hands
			raise "#{INVALIDHANDS} Some card is invalid" unless spelling_is_right hands
			raise "#{INVALIDHANDS} You cant have identical cards" unless have_any_repeated_card hands
			raise "#{INVALIDHANDS} Some card doesnt exist" unless exist_any_card hands
		end

		private

			def exist_any_card hands
				hands.each do |card|
					return false unless Deck.ranks.include?(card[0]) & Deck.suits.include?(card[1])
				end
			end

			def have_any_repeated_card hands
				hands.uniq.count == CARDS_IN_HANDS
			end

			def spelling_is_right hands
				hands.each do |card|
 					return false unless card_has_two_characters(card)
 				end
			end

			def card_has_two_characters card
				card.length == CARDS_CHARACTERS
			end

			def have_ten_card hands
				hands.count == CARDS_IN_HANDS
			end
	end
end