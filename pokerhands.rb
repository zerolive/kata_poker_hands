class PokerHands

	RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"]
	SUITS = ["C", "D", "H", "S"]

	class << self

		def build *hands
			hands = hands.map(&:upcase)
			RaiseInvalidHands.build(*hands, RANKS, SUITS)
		end

		private

			def player_hand player, rankorsuit, *hands
				hand = []
				hands.each{ |card| 	hand << card[rankorsuit] }
				return remove_cards(*hand, player)
			end

			def remove_cards *hands, player
				hands.delete_at(player) while hands.size > 5
				return hands
			end

			def translate_ranks_to_values *hands
				translated=[]
				hands.each_with_index do |card, index|
					translated << RANKSVALUE[RANKS.index(card)]
				end
				return translated
			end
	end

end

class RaiseInvalidHands
	
	CARDSINHANDS = 10
	CARDCHARS = 2

	class << self

		def build *hands, ranks, suits
			raise "Invalid hands: Wrong number of cars" unless have_ten_card *hands
			raise "Invalid hands: Some card is invalid" unless spelling_is_right *hands
			raise "Invalid hands: You cant have identical cards" unless have_any_repeated_card *hands
			raise "Invalid hands: Some card doesnt exist" unless exist_any_card(*hands, ranks, suits)
		end

		private

			def exist_any_card *hands, ranks, suits 
				hands.each do |card|
					return false unless ranks.include?(card[0]) & suits.include?(card[1])
				end
			end

			def have_any_repeated_card *hands
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
# PokerHands.build("2H","3H","4H","5H","7H","6H","5d","4D","3D","2D")
