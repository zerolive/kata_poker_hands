class PokerHands

	class << self

		def build hands
			hands = hands.map(&:upcase)

			RaiseInvalidHands.build hands
		end

		private

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

class Hand

	RANKS = 0
	SUITS = 1
	CARDS_IN_HAND = 5

	class << self

	private

		def remove_cards player, hands
			hands.delete_at(player) while hands.size > Hand::CARDS_IN_HAND
			return hands
		end

		def get_from_cards ranksorsuits, hands
			hand = []
			hands.each{ |card| hand << card[ranksorsuits] }
			return hand
		end

		def translate_ranks_to_values hand
			translated=[]
			hand.each do |card|
				translated << Deck.ranks.index(card)
			end
			return translated
		end
	end	
end

class BlackHand < Hand

	WHITE_CARDS = 5

	class << self

		def ranks hands
			hand = []
			hand = remove_cards WHITE_CARDS, hands
			hand = get_from_cards Hand::RANKS, hand
			hand = translate_ranks_to_values hand
			hand
		end

		def suits hands
			hands = hands.map(&:upcase)
			hand = []
			hand = remove_cards WHITE_CARDS, hands
			hand = get_from_cards Hand::SUITS, hand
			hand
		end
	end
end


class WhiteHand < Hand

	BLACK_CARDS = 0

	class << self

		def ranks hands
			hand = []
			hand = remove_cards BLACK_CARDS, hands
			hand = get_from_cards Hand::RANKS, hand
			hand = translate_ranks_to_values hand
			hand
		end

		def suits hands
			hands = hands.map(&:upcase)
			hand = []
			hand = remove_cards BLACK_CARDS, hands
			hand = get_from_cards Hand::SUITS, hand
			hand
		end

	end
end