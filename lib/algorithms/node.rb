module Algorithms
  class Node
    attr_accessor :next, :weight

    def initialize(n, w)
      @next, @weight = n, w
    end
  end
end
