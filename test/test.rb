require_relative '../lib/algorithms'

# ed = Algorithms::EditDistance.new('you should not', 'thou shalt not')
# ed.edit_distance
# ed.distance

graph_one = Algorithms::Graph.new('/Users/joecanero/RubyAlgos/test/graph.txt', weighted: true)
# graph_one.display

# graph_two = Algorithms::Graph.new('/Users/joecanero/RubyAlgos/test/graph2.txt', directed: true)
# graph_two.display

kruskal_tree = Algorithms::Kruskal.new(graph_one)
kruskal_tree.find
