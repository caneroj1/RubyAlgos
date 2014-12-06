require_relative '../algorithms'

ed = Algorithms::EditDistance.new('you should not', 'thou shalt not')
puts ed.edit_distance
