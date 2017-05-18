require 'rspec'
require 'shortest_path'
require 'graph'

describe 'topological_shortest_path' do
  let(:v1) { Vertex.new("Wash Markov") }
  let(:v2) { Vertex.new("Feed Markov") }
  let(:v3) { Vertex.new("Dry Markov") }
  let(:v4) { Vertex.new("Brush Markov") }
  let(:v5) { Vertex.new("Talk to Markov") }

  before(:each) do
    Edge.new(v1, v2, 2)
    Edge.new(v1, v3, 5)
    Edge.new(v2, v4, 5)
    Edge.new(v3, v4, 1)
  end

  it 'should take in a set of vertices, a start vertex, and and end vertex' do
    expect{ topological_shortest_path([v1, v2, v3, v4].shuffle, v1, v4) }.to_not raise_error
  end

  it 'should find the shortest path' do
    expect(topological_shortest_path([v1, v2, v3, v4].shuffle, v1, v4)).to eq(6)
    expect(topological_shortest_path([v1, v2, v3, v4].shuffle, v1, v3)).to eq(5)
    expect(topological_shortest_path([v1, v2, v3, v4, v5].shuffle, v1, v5)).to eq(Float::INFINITY)
    expect(topological_shortest_path([v1, v2, v3, v4].shuffle, v2, v1)).to eq(Float::INFINITY)
  end
end

describe 'dijkstra' do
  let(:v1) { Vertex.new("Wash Markov") }
  let(:v2) { Vertex.new("Feed Markov") }
  let(:v3) { Vertex.new("Dry Markov") }
  let(:v4) { Vertex.new("Brush Markov") }
  let(:v5) { Vertex.new("Talk to Markov") }

  before(:each) do
    Edge.new(v1, v2, 2)
    Edge.new(v1, v3, 5)
    Edge.new(v2, v4, 5)
    Edge.new(v3, v4, 1)
  end

  it 'should take in a set of vertices, a start vertex, and and end vertex' do
    expect{ dijkstra([v1, v2, v3, v4].shuffle, v1, v4) }.to_not raise_error
  end

  it 'should find the shortest path' do
    expect(dijkstra([v1, v2, v3, v4].shuffle, v1, v4)).to eq(6)
    expect(dijkstra([v1, v2, v3, v4].shuffle, v1, v3)).to eq(5)
    expect(dijkstra([v1, v2, v3, v4, v5].shuffle, v1, v5)).to eq(Float::INFINITY)
    expect(dijkstra([v1, v2, v3, v4].shuffle, v2, v1)).to eq(Float::INFINITY)
  end
end

describe 'dijkstra_all_paths' do
  let(:v1) { Vertex.new("A") }
  let(:v2) { Vertex.new("B") }
  let(:v3) { Vertex.new("C") }
  let(:v4) { Vertex.new("D") }

  before(:each) do
    Edge.new(v1, v2, 10)
    Edge.new(v1, v3, 5)
    Edge.new(v3, v2, 3)
    Edge.new(v1, v4, 9)
    Edge.new(v3, v4, 2)
  end

  it 'should take in a set of vertices' do
    expect{ dijkstra_all_paths([v1, v2, v3, v4], v1) }.to_not raise_error
  end

  it 'should sort the vertices correctly' do
    output = dijkstra_all_paths([v1, v2, v3, v4], v1).map do |v, data|
      [v.val, data[:cost]]
    end

    expect(output).to eq([["A", 0], ["C", 5], ["D", 7], ["B", 8]])
  end

end
