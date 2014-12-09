require_relative '../lib/algorithms'

ed = Algorithms::EditDistance.new('you should not', 'thou shalt not')
ed.edit_distance
ed.distance

puts "\n"

graph_one = Algorithms::Graph.new('/Users/joecanero/RubyAlgos/test/graph.txt', weighted: true)
graph_one.display

puts "\n"

graph_two = Algorithms::Graph.new('/Users/joecanero/RubyAlgos/test/graph2.txt', directed: false)
graph_two.display

graph_two.path(1, 4)

puts "\n"

kruskal_tree = Algorithms::Kruskal.new(graph_one)
kruskal_tree.find

puts kruskal_tree.weight

puts "\n"

graph_three = Algorithms::Graph.new('/Users/joecanero/RubyAlgos/test/graph3.txt', weighted: true)

k = Algorithms::Kruskal.new(graph_three)
k.find

puts "\n"

puts k.weight

graph_three.two_color

graph_three.connected_components

graph_one.connected_components

graph_two.two_color

graph_one.two_color

graph_four = Algorithms::Graph.new('/Users/joecanero/RubyAlgos/test/graph4.txt')

graph_four.two_color

graph_five = Algorithms::Graph.new('/Users/joecanero/RubyAlgos/test/graph5.txt')

graph_five.two_color
