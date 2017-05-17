class Vertex
  attr_accessor :val, :in_edges, :out_edges

  def initialize(val)
    @val = val
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    @cost = cost
    add(from_vertex, to_vertex)
  end

  def add(from, to)
    from.out_edges << self
    to.in_edges << self
  end

  def destroy!
    @from_vertex.out_edges.delete(self)
    @from_vertex = nil
    @to_vertex.in_edges.delete(self)
    @to_vertex = nil
  end
end
