require_relative 'graph'

def dfs_topological_sort(vertices, seen = Set.new, sorted = [])
  return sorted if vertices.empty?
  vertices.each do |vertex|
    seen.include?(vertex) ? next : seen.add(vertex)
    neighbors = []
    vertex.out_edges.each do |edge|
      neighbors << edge.to_vertex unless seen.include?(edge.to_vertex)
    end
    dfs_topological_sort(neighbors, seen, sorted)
    sorted.unshift(vertex)
  end

  sorted
end
