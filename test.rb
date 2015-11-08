class PokerHands

	RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
	RANKSVALUE = [2,3,4,5,6,7,8,9,10,11,12,13,14]
	SUITS = ["C", "D", "H", "S"]

	class << self

		def build *hands
			p translate_ranks_to_values(*hands)
			p RANKS.index("2")
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

#PokerHands.build("2H","3H","4H","5H","7H","6H","5D","4D","3D","2D")
PokerHands.build("2","3","4","5","7","T","J","Q","K","A")