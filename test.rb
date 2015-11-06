class PokerDeck
	RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"]
	SUITS = ["C", "D", "H", "S"]

	class << self

		def build *hands
			check_card *hands
		end

		def print
			SUITS.each do |suit|
				RANKS.each do |rank|
					card = ""
					card << rank
					card << suit
					p card
				end
			end
		end

		def check_card *hands
			hands.each do |card|
				puts "Wrong card #{card}" unless RANKS.include?(card[0]) & SUITS.include?(card[1])
			end
		end
	end

end
#(RANKS.include?(card[0]) && SUITS.include?(card[1]))
PokerDeck.build("AD", "2G", "4H")