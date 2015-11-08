class PokerHands

	RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
	SUITS = ["C", "D", "H", "S"]

	class << self

		def build *hands
			p "Black ranks #{player_hand(5, 1, *hands)}"
			p "Black suits "
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
	end

end

PokerHands.build("2H","3H","4H","5H","7h","6H","5D","4D","3D","2D")