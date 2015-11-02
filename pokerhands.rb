class PokerHands

	class << self

		def build *cards
			raise "Invalid hands: Wrong number of cars" if cards.count != 10
		end

		private

	end

end
