class PokerHands

	RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
	RANKSVALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
	SUITS = ["C", "D", "H", "S"]
	CARDSINHAND = 5

	class << self

		def build *hands
			hands = hands.map(&:upcase)
			RaiseInvalidHands.build(*hands, RANKS, SUITS)
			winner = ""
			winner = HighCard.build(*hands)
			return winner
		end

		private


			def player_hand player, rankorsuit, *hands
				rankorsuitvalue = 1 if rankorsuit == "suits"
				rankorsuitvalue = 0
				hand = []
				hands.each{ |card| 	hand << card[rankorsuitvalue] }
				return remove_cards(*hand, player)
			end

			def remove_cards *hands, player
				playervalue = 0
				playervalue = 5 if player == "black"
				hands.delete_at(playervalue) while hands.size > CARDSINHAND
				return hands
			end

			def ranks_to_values *hands
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

class HighCard < PokerHands
	class << self

		def build *hands
			highblackcard = high_card(*ranks_to_values(*player_hand("black", "ranks", *hands)))
			highwhitekcard = high_card(*ranks_to_values(*player_hand("white", "ranks", *hands)))
			return "Black player wins with Hightest card" if highblackcard > highwhitekcard
			return "White player wins with Hightest card" if highwhitekcard > highblackcard
			return "Tie"
		end

		private

		def high_card *hand
			highcard = 0
			hand.each do |card|
				highcard = card if card > highcard
			end
			return highcard
		end
	end

end

#p PokerHands.build("2c","3c","4c","5H","9h","6H","5c","4D","3D","2D")