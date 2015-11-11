class Prueba
	def self.build hand
		duplicado = hand.select{|element| hand.count(element) > 1 }
		p duplicado.uniq.max
		p  "false" if !duplicado.uniq.min
	end
end

Prueba.build([2,2,3,3,4])