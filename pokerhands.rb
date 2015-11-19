class PokerHands

	RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
	RANKSVALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
	SUITS = ["C", "D", "H", "S"]
	CARDSINHAND = 5
	LASTCARD = 4
	RANK = 0
	SUIT = 1

	class << self

		def build hands
			hands = hands.map(&:upcase)

			RaiseInvalidHands.build(hands, RANKS, SUITS)

			return StraightFlush.build(hands)
		end

		private

			def both_have_flush handone, handtwo
				has_flush_in(handone) && has_flush_in(handtwo)
			end

			def has_flush_in hand
				hand.uniq.count == 1
			end

			def both_have_straight handone, handtwo
				have_straight_in(handone) && have_straight_in(handtwo)
			end

			def player_ranks player, hands
				hand = []
				hand = remove_suits(hands)
				hand = remove_other_hand(player, hand)
				return translate_ranks_to_value(hand)
			end

			def remove_other_hand player, hands
				playername = 0
				playername = 5 if player == "black"

				hands.delete_at(playername) while hands.size > CARDSINHAND
				return hands
			end

			def remove_suits hands
				hand = []
				hands.each{ |card| 	hand << card[RANK] }
				return hand
			end

			def translate_ranks_to_value hand
				translated=[]
				hand.each do |card|
					translated << RANKSVALUE[RANKS.index(card)]
				end
				return translated
			end

			def duplicate_ranks hand
				dupcards = hand.select do |checkcard|
					hand.count(checkcard) > 1
				end
				return dupcards
			end

			def both_have category, pairone, pairtwo
				pairone.count == category && pairtwo.count == category
			end

			def have_straight_in hand
				count = 0
				hand.sort.each_with_index do |card, index|
					count += 1 if (card+1) == (hand.sort[index+1])
				end
				return hand.max if count == 4
				return false
			end

			def player_suits player, hands
				hand = []
				firstcard = 0
				firstcard = 5 if player == "black"
				hands.each{ |card| 	hand << card[SUIT] }
				hand.delete_at(firstcard) while hand.size > CARDSINHAND
				return hand
			end


			def has_highest_card handone, handtwo
				position = LASTCARD
				while position >= 0
					return true if handone.sort[position] > handtwo.sort[position]
					position -= 1
				end
			end
	end

end

class RaiseInvalidHands
	
	CARDSINHANDS = 10
	CARDCHARS = 2
	INVALIDHANDS = "Invalid hands:"

	class << self

		def build hands, ranks, suits
			raise "#{INVALIDHANDS} Wrong number of cars" unless have_ten_card hands
			raise "#{INVALIDHANDS} Some card is invalid" unless spelling_is_right hands
			raise "#{INVALIDHANDS} You cant have identical cards" unless have_any_repeated_card hands
			raise "#{INVALIDHANDS} Some card doesnt exist" unless exist_any_card(hands, ranks, suits)
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

class StraightFlush < PokerHands

	class << self

		def build hands
			blackranks = player_ranks("black", hands)
			whiteranks = player_ranks("white", hands)
			blacksuits = player_suits("black", hands)
			whitesuits = player_suits("white", hands)

			if both_have_straightflush(blackranks, blacksuits, whiteranks, whitesuits)
				return "Black player wins with the highest straight flush" if has_highest_straight_flush_on(blackranks, whiteranks)
				return "White player wins with the highest straight flush" if has_highest_straight_flush_on(whiteranks, blackranks)
				return "Tie with straight flush" if both_have_same_straight_flush(blackranks, whiteranks)
			end

			return "Black player wins with straight flush" if only_has_straightlush_in(blackranks, blacksuits, whiteranks)
			return "White player wins with straight flush" if only_has_straightlush_in(whiteranks, whitesuits, blackranks)

			return FourKind.build(hands)
		end

		private

			def only_has_straightlush_in handoneranks, handonesuits, handtworanks
				have_straight_in(handoneranks) && has_flush_in(handonesuits) && !have_straight_in(handtworanks)
			end

			def both_have_straightflush handoneranks, handonesuits, handtworanks, handtwosuits
				have_straight_in(handoneranks) && has_flush_in(handonesuits) && have_straight_in(handtworanks) && has_flush_in(handtwosuits)
			end

			def has_highest_straight_flush_on handone, handtwo
				have_straight_in(handone) > have_straight_in(handtwo)
			end

			def both_have_same_straight_flush handone, handtwo
				have_straight_in(handone) == have_straight_in(handtwo)
			end

	end

end

class FourKind < PokerHands

	FOURKIND = 4

	class << self

		def build hands
			blackranks = player_ranks("black", hands)
			whiteranks = player_ranks("white", hands)
			blackfour = duplicate_ranks(blackranks)
			whitefour = duplicate_ranks(whiteranks)

			if both_have_four_kind(blackfour, whitefour)
				return "Black player wins with the highest four of a kind" if has_highest_four(blackfour, whitefour)
				return "White player wins with the highest four of a kind" if has_highest_four(whitefour, blackfour)
			end

			return "Black player wins with four of a kind" if has_four_kind(blackfour)
			return "White player wins with four of a kind" if has_four_kind(whitefour)

			return FullHouse.build(hands)
		end

		private

			def has_four_kind hand
				hand.count == FOURKIND and hand.uniq.count == 1
			end

			def both_have_four_kind handone, handtwo
				has_four_kind(handone) && has_four_kind(handtwo)
			end

			def has_highest_four handone, handtwo
				handone[0] > handtwo[0]
			end

	end

end

class FullHouse < PokerHands

	class << self

		def build hands
			blackranks = player_ranks("black", hands)
			whiteranks = player_ranks("white", hands)

			if both_have_full_house(blackranks, whiteranks)
				return "Black player wins with the highest full house" if has_highest_full_house_on(blackranks, whiteranks)
				return "White player wins with the highest full house" if has_highest_full_house_on(whiteranks, blackranks)
			end

			return "Black player wins with full house" if has_full_house(blackranks)
			return "White player wins with full house" if has_full_house(whiteranks)

			return Flush.build(hands)
		end

		def has_full_house hand
			hand.uniq.count == 2
		end

		def both_have_full_house handone, handtwo
			has_full_house(handone) and has_full_house(handtwo)
		end

		def has_highest_full_house_on handone, handtwo
			handone.max > handtwo.max
		end

	end

end

class Flush < PokerHands

	class << self

		def build hands
			blackranks = player_ranks("black", hands)
			whiteranks = player_ranks("white", hands)
			blacksuits = player_suits("black", hands)
			whitesuits = player_suits("white", hands)

			if both_have_flush(blacksuits, whitesuits)
				return "Black player wins with the highest flush" if has_highest_card(blackranks, whiteranks)
				return "White player wins with the highest flush" if has_highest_card(whiteranks, blackranks)
				return "Tie with flush" if both_have_same_flush(blackranks, whiteranks)
			end

			return "Black player wins with flush" if has_flush_in(blacksuits)
			return "White player wins with flush" if has_flush_in(whitesuits)

			return Straight.build(blackranks, whiteranks)
		end

		private

			def both_have_same_flush handone, handtwo
				handone.sort == handtwo.sort
			end
	end

end

class Straight < PokerHands

	class << self

		def build blackhand, whitehand
			if both_have_straight(blackhand, whitehand)
				blackstraight = have_straight_in(blackhand)
				whitestraight = have_straight_in(whitehand)
				return "Black player wins with the highest straight" if blackstraight > whitestraight
				return "White player wins with the highest straight" if whitestraight > blackstraight
				return "Tie with straight" if blackstraight == whitestraight
			end

			return "Black player wins with straight" if have_straight_in(blackhand)
			return "White player wins with straight" if have_straight_in(whitehand)

			return ThreeKind.build(blackhand, whitehand)
		end

	end

end

class ThreeKind < PokerHands

	class << self

		THREEKIND = 3

		def build blackhand, whitehand
			blackthree = duplicate_ranks(blackhand)
			whitethree = duplicate_ranks(whitehand)			

			if both_have(THREEKIND, blackthree, whitethree)
				return "Black player wins with the highest three of a kind" if has_highest_three_kind_in(blackthree, whitethree)
				return "White player wins with the highest three of a kind" if whitethree[0] > blackthree[0]
			end

			return "Black player wins with three of a kind" if has_three_kind_in(blackthree)
			return "White player wins with three of a kind" if has_three_kind_in(whitethree)

			return TwoPairs.build(blackhand, whitehand)
		end

		private

			def has_three_kind_in hand
				hand.count == THREEKIND
			end

			def has_highest_three_kind_in handone, handtwo
				handone[0] > handtwo[0]
			end
	end

end

class TwoPairs < PokerHands

	TWOPAIRS = 2

	class << self

		def build blackhand, whitehand
			blackpairs = duplicate_ranks(blackhand).uniq
			whitepairs = duplicate_ranks(whitehand).uniq

			if both_have(TWOPAIRS, blackpairs, whitepairs)
				return "White player wins with the highest Pairs" if best_pairs_belongs(whitepairs, blackpairs)
				return "Black player wins with the highest Pairs" if best_pairs_belongs(blackpairs, whitepairs)
				return "Tie with Pairs" if have_same_pairs(blackpairs, whitepairs)
			end

			return "Black player wins with Pairs" if blackpairs.count == TWOPAIRS
			return "White player wins with Pairs" if whitepairs.count == TWOPAIRS

			return HighPair.build(blackhand, whitehand)
		end

		private

			def everyone_have_pairs pairs, pairstocompare
				pairs.count == TWOPAIRS && pairstocompare.count == TWOPAIRS
			end

			def best_pairs_belongs pairs, pairstocompare
				return true if pairs.max > pairstocompare.max
				return false if pairs.max < pairstocompare.max
				return true if pairs.min > pairstocompare.min
			end

			def have_same_pairs pairs, pairstocompare
				pairs.max == pairstocompare.max && pairs.min == pairstocompare.min
			end
	end

end

class HighPair < PokerHands

	ONEPAIR = 2

	class << self

		def build blackhand, whitehand
			blackpair = duplicate_ranks(blackhand)
			whitepair = duplicate_ranks(whitehand)

			if both_have(ONEPAIR, blackpair, whitepair)
				return "Black player wins with the highest Pair" if has_highest_pair_on(blackpair, whitepair)
				return "White player wins with the highest Pair" if has_highest_pair_on(whitepair, blackpair)
				return "Tie with Pair" if both_have_same_pair(blackpair, whitepair)
			end

			return "Black player wins with Pair" if only_has_pair_in(blackpair, whitepair)
			return "White player wins with Pair" if only_has_pair_in(whitepair, blackpair)

			return HighCard.build(blackhand, whitehand)
		end

		private

			def only_has_pair_in pairone, pairtwo
				!pairone.empty? && pairtwo.empty?
			end

			def has_highest_pair_on handone, handtwo
				handone[0] > handtwo[0]
			end

			def both_have_same_pair handone, handtwo
				handone == handtwo
			end

	end

end

class HighCard < PokerHands

	class << self

		def build blackhand, whitehand
			return "Black player wins with the highest card" if has_highest_card(blackhand, whitehand)
			return "White player wins with the highest card" if has_highest_card(whitehand, blackhand)
			return "Tie with the highest card" if blackhand.sort == whitehand.sort
		end

	end

end