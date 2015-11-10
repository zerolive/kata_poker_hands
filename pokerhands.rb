class PokerHands

	RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
	RANKSVALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
	SUITS = ["C", "D", "H", "S"]
	CARDSINHAND = 5

	class << self

		def build hands
			hands = hands.map(&:upcase)
			RaiseInvalidHands.build(hands, RANKS, SUITS)
			return HighPair.build(hands)
		end

		private


			def player_hand player, rankorsuit, hands
				rankorsuitvalue = 0
				rankorsuitvalue = 1 if rankorsuit == "suits"
				hand = []
				hands.each{ |card| 	hand << card[rankorsuitvalue] }
				return remove_cards(hand, player)
			end

			def remove_cards hands, player
				playervalue = 0
				playervalue = 5 if player == "black"
				hands.delete_at(playervalue) while hands.size > CARDSINHAND
				return ranks_to_values(hands)
			end

			def ranks_to_values hands
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

		def build hands, ranks, suits
			raise "Invalid hands: Wrong number of cars" unless have_ten_card hands
			raise "Invalid hands: Some card is invalid" unless spelling_is_right hands
			raise "Invalid hands: You cant have identical cards" unless have_any_repeated_card hands
			raise "Invalid hands: Some card doesnt exist" unless exist_any_card(hands, ranks, suits)
		end

		private

			def exist_any_card hands, ranks, suits 
				hands.each do |card|
					return false unless ranks.include?(card[0]) & suits.include?(card[1])
				end
			end

			def have_any_repeated_card hands
				return hands.uniq.count == CARDSINHANDS
			end

			def spelling_is_right hands
				hands.each do |card|
 					return false unless card_has_two_characters(card)
 				end
			end

			def card_has_two_characters card
				return card.length == CARDCHARS
			end

			def have_ten_card hands
				return hands.count == CARDSINHANDS
			end
	end

end

class HighPair < PokerHands

	NOPAIRS = 5

	class << self

		def build hands
			blackhand = player_hand("black", "ranks", hands)
			whitehand = player_hand("white", "ranks", hands)

			return "Black player wins with the highest Pair" if has_highest_pair(blackhand, whitehand)
			return "White player wins with the highest Pair" if has_highest_pair(whitehand, blackhand)

			return "Black player wins with Pair" if has_pair_in(blackhand) && !has_pair_in(whitehand)
			return "White player wins with Pair" if has_pair_in(whitehand) && !has_pair_in(blackhand)

			return "Tie" if both_have_same_pair(blackhand, whitehand)

			return HighCard.build(hands)
			
		end

		private

			def high_pair hand
				card = 0
				hand.detect do | checkcard | 
					card = checkcard if hand.count(checkcard) > 1 
				end
				return card
			end

			def has_pair_in hand
				hand.uniq.count != NOPAIRS
			end

			def both_have_same_pair blackhand, whitehand
				(high_pair(blackhand) == high_pair(whitehand)) && has_pair_in(blackhand)
			end

			def has_highest_pair handone, handtwo
				(high_pair(handone) > high_pair(handtwo)) && has_pair_in(handtwo)
			end
	end

end

class HighCard < PokerHands

	class << self

		def build hands
			blackhand = player_hand("black", "ranks", hands)
			whitehand = player_hand("white", "ranks", hands)
			return "Black player wins with the highest card" if has_highest_card(blackhand, whitehand)
			return "White player wins with the highest card" if has_highest_card(whitehand, blackhand)
			return "Tie"
		end

		private

			def high_card hand
				highcard = 0
				hand.each do |card|
					highcard = card if card > highcard
				end
				return highcard
			end

			def has_highest_card handone, handtwo
				high_card(handone) > high_card(handtwo)
			end
	end

end

#PokerHands.build(["2c","2d","4c","3d","ah","6H","7c","5h","4d","3c"])