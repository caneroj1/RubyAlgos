module Algorithms
  class Edge
    attr_accessor :x, :y, :weight

    def initialize(x, y, weight)
      @x, @y = x, y
      @weight = weight
    end
  end
end
