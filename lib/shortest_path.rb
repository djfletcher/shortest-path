require_relative 'graph'
require_relative 'topological_sort'
require 'set'
require 'byebug'



def topological_shortest_path(vertices, start, finish)
  data = {}
  sorted = dfs_topological_sort(vertices)
  # save meta data associated with each vertex in a hash
  sorted.each do |v|
    data[v] = {
      cost: v == start ? 0 : Float::INFINITY,
      prev: nil
    }
  end

  # impossible to reach earlier vertices in DAG
  start_idx = sorted.index(start)
  sorted[start_idx..-1].each do |v|
    v.out_edges.each do |edge|
      child = edge.to_vertex
      if data[v][:cost] + edge.cost < data[child][:cost]
        data[child][:cost] = data[v][:cost] + edge.cost
        data[child][:prev] = v
      end
    end
  end

  data[finish][:cost]
end


def dijkstra(vertices, start, finish)
  data = {}
  unexplored = vertices.dup
  unexplored.each do |v|
    data[v] = {
      cost: v == start ? 0 : Float::INFINITY,
      prev: nil
    }
  end

  until unexplored.empty?
    vertex = extract_min(unexplored, data)
    vertex.out_edges.each do |edge|
      child = edge.to_vertex
      if data[vertex][:cost] + edge.cost < data[child][:cost]
        data[child][:cost] = data[vertex][:cost] + edge.cost
        data[child][:prev] = vertex
      end
    end
  end

  data[finish][:cost]
end

def extract_min(array, data)
  array.sort! { |a, b| data[a][:cost] <=> data[b][:cost] }.shift
end



v1 = Vertex.new("Wash Markov")
v2 = Vertex.new("Feed Markov")
v3 = Vertex.new("Dry Markov")
v4 = Vertex.new("Brush Markov")
v5 = Vertex.new("Talk to Markov")

Edge.new(v1, v2, 2)
Edge.new(v1, v3, 5)
Edge.new(v2, v4, 5)
Edge.new(v3, v4, 1)

puts topological_shortest_path([v1, v2, v3, v4].shuffle, v1, v4) == 6
puts topological_shortest_path([v1, v2, v3, v4].shuffle, v1, v3) == 5
puts topological_shortest_path([v1, v2, v3, v4, v5].shuffle, v1, v5) == Float::INFINITY
puts topological_shortest_path([v1, v2, v3, v4].shuffle, v2, v1) == Float::INFINITY

puts dijkstra([v1, v2, v3, v4].shuffle, v1, v4) == 6
puts dijkstra([v1, v2, v3, v4].shuffle, v1, v3) == 5
puts dijkstra([v1, v2, v3, v4, v5].shuffle, v1, v5) == Float::INFINITY
puts dijkstra([v1, v2, v3, v4].shuffle, v2, v1) == Float::INFINITY
